#!/bin/sh


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
  COMPRESS_OUTPUTIMAGE=sha,gpg,im | tee ${LOG}

sudo ./userpatches/post-build/create_snapshots.sh

#  DISABLE_IPV6=false \
#  EXTERNAL=yes \
#  EXTERNAL_NEW=compile \
#  INSTALL_HEADERS=yes \
#  INSTALL_KSRC=yes \
