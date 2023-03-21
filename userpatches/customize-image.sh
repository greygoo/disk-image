#!/bin/bash

# arguments: $RELEASE $LINUXFAMILY $BOARD $BUILD_DESKTOP
#
# This is the image customization script

# NOTE: It is copied to /tmp directory inside the image
# and executed there inside chroot environment
# so don't reference any files that are not already installed

# NOTE: If you want to transfer files between chroot and host
# userpatches/overlay directory on host is bind-mounted to /tmp/overlay in chroot
# The sd card's root path is accessible via $SDCARD variable.

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

Main() {
	echo "Installing git"
       	yes | DEBIAN_FRONTEND=noninteractive apt-get -yqq install git
	echo "Checking out installer"
	rm -rf /tmp/installer
	git clone https://github.com/greygoo/system-installer.git /tmp/installer
	echo "Run installer"
	pushd /tmp/installer
	./install.sh $RELEASE $LINUXFAMILY $BOARD
	popd
} # Main

Main "$@"
