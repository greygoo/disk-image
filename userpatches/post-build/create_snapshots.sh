#!/bin/sh


LOOP_DEV=$(losetup -f)

if [ ! -f output/images/Armbian*.img ]; then
  echo "No image file found, exiting"
  exit 1
fi

trap "losetup -d ${LOOP_DEV}" INT TERM
mkdir /tmp/armbian

echo "Mounting built image"
losetup -P ${LOOP_DEV} output/images/Armbian*.img
mount ${LOOP_DEV}p2 /tmp/armbian/

echo "Moving /home to a subvolume"
mv /tmp/armbian/home/ /tmp/armbian/home.orig
btrfs subvolume create /tmp/armbian/home/
mv /tmp/armbian/home.orig/* /tmp/armbian/home/
rmdir /tmp/armbian/home.orig

echo "Adding entry for subvolume /home to /etc/fstbab"
HOME_ID=`btrfs subvolume list /tmp/armbian/ | egrep "home$" | awk '{ print $2 }'`
LABEL=`cat /tmp/armbian/etc/fstab | grep " / " | awk ' { print $1 } ' | sed "s/UUID=//"`
sed -i "2i UUID=$LABEL /home btrfs defaults,noatime,commit=600,subvolid=$HOME_ID 0 1" /tmp/armbian/etc/fstab

echo "Create snapshots for / and /home"
btrfs subvolume create /tmp/armbian/.snapshots
btrfs subvolume snapshot /tmp/armbian/home /tmp/armbian/.snapshots/restore_home
btrfs subvolume snapshot /tmp/armbian /tmp/armbian/.snapshots/restore_root

btrfs subvolume list /tmp/armbian

echo "Unmounting image"
umount /tmp/armbian
losetup -d ${LOOP_DEV}
