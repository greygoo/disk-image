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

echo "Create snapshots for / and /home"
btrfs subvolume create /tmp/armbian/.snapshots

btrfs subvolume snapshot /tmp/armbian /tmp/armbian/.snapshots/root_factory
btrfs subvolume snapshot /tmp/armbian /tmp/armbian/.snapshots/root_current

btrfs subvolume snapshot /tmp/armbian/home /tmp/armbian/.snapshots/home_factory
btrfs subvolume snapshot /tmp/armbian/home /tmp/armbian/.snapshots/home_current

echo Setting root id
current_root_id=$(btrfs sub list /tmp/armbian/ | grep root_current | awk '{ print $2 }')
btrfs sub set-default $current_root_id /tmp/armbian

echo "Adding entry for subvolume /home to /etc/fstab"
current_home_id=$(btrfs sub list /tmp/armbian/home | grep home_current | awk '{ print $2 }')
label=`cat /tmp/armbian/etc/fstab | grep " / " | awk ' { print $1 } ' | sed "s/UUID=//"`
sed -i "2i UUID=$label /home btrfs defaults,noatime,commit=600,subvolid=$current_home_id 0 1" /tmp/armbian/etc/fstab

echo New fstab:
cat /tmp/armbian/etc/fstab

echo "Finale subvolume setup:"
btrfs subvolume list /tmp/armbian

echo "Unmounting image"
umount /tmp/armbian
losetup -d ${LOOP_DEV}
