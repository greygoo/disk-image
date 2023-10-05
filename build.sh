#!/bin/sh

if [ ! -f compile.sh ] && [ -d build ]; then
  echo "No compile.sh found. Please change into the build dir"
  exit 1
elif [ ! -f compile.sh ] && [ ! -d build ]; then
  echo "No compile.sh and not build dir found. Please run install.sh"
  exit 1
fi


LOG="build.log"
rm ${LOG}

BOARD=${1:-"orangepi3-lts"}
. ./boards/${BOARD}

echo BOARD: "${BOARD}"
echo RELEASE: "${RELEASE}"
echo BRANCH: "${BRANCH}"
echo ROOTFS_TYPE: "${ROOTFS_TYPE}"

./compile.sh \
  BOARD=${BOARD} \
  RELEASE=${RELEASE} \
  BRANCH=${BRANCH} \
  ROOTFS_TYPE="${ROOTFS_TYPE}" \
  BUILD_MINIMAL=yes \
  BUILD_DESKTOP=no \
  BUILD_ONLY=default \
  EXTRAWIFI=yes \
  CONSOLE_AUTOLOGIN=no \
  PREFER_DOCKER=yes \
  CLEAN_LEVEL=cache,make,images \
  KERNEL_CONFIGURE=no \
  COMPRESS_OUTPUTIMAGE=sha,gpg,im | tee ${LOG}

if [[ $ROOTFS_TYPE == "btrfs" ]]; then
  sudo ./userpatches/post-build/create_snapshots.sh
fi

#  DISABLE_IPV6=false \
#  EXTERNAL=yes \
#  EXTERNAL_NEW=compile \
#  INSTALL_HEADERS=yes \
#  INSTALL_KSRC=yes \
