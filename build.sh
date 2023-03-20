#!/bin/sh


LOG="build.log"
BOARD="orangepi3-lts"
rm ${LOG}

echo ${BOARD}

./compile.sh \
  BOARD=${BOARD} \
  DISABLE_IPV6=false \
  BRANCH=current \
  RELEASE=jammy \
  BUILD_MINIMAL=yes \
  BUILD_DESKTOP=no \
  BUILD_ONLY=default \
  ROOTFS_TYPE=btrfs \
  KERNEL_CONFIGURE=no \
  KERNEL_KEEP_CONFIG=no \
  EXTRAWIFI=yes \
  EXTERNAL=yes \
  EXTERNAL_NEW=compile \
  INSTALL_HEADERS=yes \
  INSTALL_KSRC=yes \
  CONSOLE_AUTOLOGIN=yes \
  PREFER_DOCKER=yes \
  CLEAN_LEVEL=cache \
  COMPRESS_OUTPUTIMAGE=sha,gpg,im | tee ${LOG}

./post-build/create_snapshots.sh
