#!/bin/sh

BRANCH=${1:-"v23.02"}

echo "Using branch ${BRANCH}. If you like to build the latest armbian, run: $0 main"

echo "Cloning Armbian build system"
git clone --branch=${BRANCH} https://github.com/armbian/build

echo "Patching build syste"
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

echo "Copying configuration"
cp -r userpatches build

echo "Copying build script"
cp build.sh build
