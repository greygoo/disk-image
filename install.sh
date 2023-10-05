#!/bin/bash

BRANCH=${1:-"main"}

echo "Using branch ${BRANCH}. If you like to build with a branch of the build system, run: $0 <>"

if [ ! -d build ]; then
    echo "Cloning Armbian build system"
    git clone --branch=${BRANCH} https://github.com/armbian/build

    echo "Patching build system"
    # For 5.15 kernel (old build system)
    if [ ${BRANCH} == "v23.02" ]; then
        pushd build
        # Enable 8188 EUS WiFi when builing the image. Requires kernel recompilation
        patch -p1 < ../patch/0000_enable_8188EUS.patch
        popd
    fi 

    # For 6.1 kernel (new build system)
    if [ ${BRANCH} == "main" ]; then
      pushd build
      # Add patches here 

      popd
  fi
else
    echo "build directory exists, only updating userpatches"
fi

echo "Adding userpatches"
rm -rf build/userpatches
cp -r userpatches build

echo "Adding build script"
cp build.sh build
cp -r boards build
