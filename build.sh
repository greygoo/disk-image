#!/bin/sh

if [ ! -f compile.sh ] && [ -d build ]; then
  echo "No compile.sh found. Please change into the build dir"
  exit 1
elif [ ! -f compile.sh ] && [ ! -d build ]; then
  echo "No compile.sh and not build dir found. Please run install.sh"
  exit 1
fi  
  

LOG="build.log"
BOARD="orangepi3-lts"
rm ${LOG}

echo ${BOARD}

./compile.sh \
  BOARD=${BOARD} \
  BRANCH=current \
  RELEASE=jammy \
  BUILD_MINIMAL=yes \
  BUILD_DESKTOP=no \
  BUILD_ONLY=default \
  ROOTFS_TYPE=btrfs \
  EXTRAWIFI=yes \
  CONSOLE_AUTOLOGIN=no \
  PREFER_DOCKER=yes \
  CLEAN_LEVEL=cache,make,images \
  KERNEL_CONFIGURE=no \
  COMPRESS_OUTPUTIMAGE=sha,gpg,im | tee ${LOG}

sudo ./userpatches/post-build/create_snapshots.sh

#  DISABLE_IPV6=false \
#  EXTERNAL=yes \
#  EXTERNAL_NEW=compile \
#  INSTALL_HEADERS=yes \
#  INSTALL_KSRC=yes \
