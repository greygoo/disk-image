#!/bin/sh


LOOP_DEV=$(losetup -f)
trap "losetup -d ${LOOP_DEV}" INT

echo "Mounting built image"
losetup -P ${LOOP_DEV} output/images/Armbian*.img
mount ${LOOP_DEV}p2 /opt/armbian/

echo "Moving /home to a subvolume"
mv /opt/armbian/home/ /opt/armbian/home.orig
btrfs subvolume create /opt/armbian/home/
mv /opt/armbian/home.orig/* /opt/armbian/home/

echo "Adding entry for subvolume /home to /etc/fstbab"
HOME_ID=`btrfs subvolume list /opt/armbian/ | egrep "home$" | awk '{ print $2 }'`
LABEL=`cat /opt/armbian/etc/fstab | grep " / " | awk ' { print $1 } ' | sed "s/UUID=//"`
sed -i "2i UUID=$LABEL /home btrfs defaults,noatime,commit=600,subvolid=$HOME_ID 0 1" /opt/armbian/etc/fstab

echo "Create snapshots for / and /home"
btrfs subvolume create /opt/armbian/.snapshots
btrfs subvolume snapshot /opt/armbian/home /opt/armbian/.snapshots/restore_home
btrfs subvolume snapshot /opt/armbian /opt/armbian/.snapshots/restore_root

btrfs subvolume list /opt/armbian

echo "Unmounting image"
umount /opt/armbian
losetup -d ${LOOP_DEV}
