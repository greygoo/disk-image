# disk-image

## Releases

### Alpha 1
Image: https://drive.google.com/file/d/1U7AHDiOMxg0NtLUYzwZ4HnaizRrUrFgd/view?usp=sharing
Release Notes: https://github.com/greygoo/disk-image/blob/main/release_notes/release_notes_EN-20231004.md

## Description
Wrapper to setup armbian build environment with Radio-Meshnet modifications

## Requirements
Ubuntu Jammy with 4GB Ram an 50GB disk space.

## Usage
To build an Radio-Meshnet Armbian image, simply run

- Clone This Repo
```
git clone https://github.com/greygoo/disk-image.git
cd disk-image
```

- Install the Armbian Build System
```
./install.sh
```

- Build a Radio-Meshnet Image
```
cd build
./build.sh
``` 
