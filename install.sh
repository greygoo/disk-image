#!/bin/sh

BRANCH=${1:-"v23.02"}

echo "Using branch ${BRANCH}. If you like to build the latest armbian, run: $0 main"

echo "Cloning Armbian build system"
git clone --branch=${BRANCH} https://github.com/armbian/build

echo "Patching build syste"
pushd build
patch -p1 < ../patch/0000_enable_8188EUS.patch
popd 

echo "Copying configuration"
cp -r userpatches build

echo "Copying build script"
cp build.sh build
