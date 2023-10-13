Latest version of this document: https://github.com/greygoo/disk-image/blob/main/release_notes/release_notes-Alpha2-20231013_EN.md 

# Description
This is the Alpha2 release of an Armbian image for OrangePi3-LTS, containing preconfigured packages for RF related tasks 

# Known Issues
Issue: direwolf configuration files are not yet working
Workaround: fix or wait for next release

Issue: soundmodem configuration files are not yet working
Workaround: fix or wait for next release

# Changes for alpha2
## Added Packages
### SDR Packages
- rtl-sdr
- gqrx-sdr

### Osmocom Packages
- extrepo

### Service Packages
- pulseaudio
- pavucontrol
- soundmodem
- direwolf

### QTsoundmodem PAckages
- qtbase5-dev
- libqt5serialport5
- libqt5serialport5-dev
- libfftw3-dev
- libpulse-dev
- libasound2-dev
- libkf5pulseaudioqt-dev

## Added Tools
- QtSoundmodem
- emmc_install.sh

## Added Services
- emmc_install

# Configuration
- Default User: `nomad`
- Default Password: `nomad`

# Content
## Armbian
The base is an Armbian minimal build with the following configuration:
- BRANCH `current`
- RELEASE `jammy`

## Reticulum
Reticulum comes as python packages and is installed in the home of user `nomad`. Two systemd service files are added to the system, that start the rns service and the `nomadnet` commandline app in a screen session for the user `nomad`. Also a GUI application called `sideband` is installed and can be launched from the desktop.

### Reticulum Python Packages
- rns
- lxmf
- nomadnet
- requests
- sbapp

### Reticulum Service Files
- /etc/systemd/system/rnsd.service
- /etc/systemd/system/nomadnet.service

## Other Installed Debian Packages

### Requirements for RNS
- libgl1-mesa-dev
- python3-pip
- python3-setuptools
- build-essential
- python3-dev
- libffi-dev
- cargo
- libssl-dev
- python3-wheel
- rust-all
- python3-setuptools-rust
- python3-pil
- python3-pygame  

### Console Tools
- iw
- tcpdump
- git
- iptables
- nftables
- bridge-utils
- vim
- btrfs-progs
- armbian-config
- screen

### Desktop
- wireshark
- libxkbcommon-x11-0
- xsel
- fonts-roboto
- lightdm-gtk-greeter
- lightdm-gtk-greeter-settings
- xfonts-base
- tightvncserver
- x11vnc
- xorg
- lightdm
- xfce4
- tango-icon-theme
- gnome-icon-theme
- dbus-x11

### Services
- firewalld
- i2pd

# Installation
## Linux
1. insert a Micro SD Card into the Computer you have downloaded the image to
2. determine the sd card device
```
lsblk
```
3. write image to sd card
```
sudo dd if=output/images/Armbian_23.08.0-trunk_Orangepi3-lts_jammy_current_6.1.55_minimal.img of=<sd device> bs=1M oflag=sync status=progress
```
4. insert the micro SD Card into the Orange Pi 3 LTS and connect it to power


# Basic Usage
## Nomadnet
- Connect to running session, run as user nomad:
```
screen -x
```

- Disconnect:
```CTRL+a+d```

**Note:** This session is started upon bootup for the user in order to be able to run it without a display connected. If you quit this instance, you can always restart NomadNet by running
```
nomadnet
```

## Sideband
TODO

## Factory Reset 
**NOTE** A factory reset will remove all changes you made so far to the system!
The image is configured with btrfs and has a snapshot of the state after first boot. In order to reset the device, run
```
factory-reset
```

## LoRa Configuration
To change the settings for your connected LoRa device, please run
```
lora_config.sh
```

## Install to emmc
### Run manually
To install the current image on sd card to the internal emmc of the sbc, run
```
sudo emmc_install.sh
```

### Run automatic at boot
To automatically install the image on the sd card on bootup for unattended emmc install, boot the sd card and run
```
sudo sysconfig enable emmc-install@tty1
```
Now reboot the sbc. the output of the emmc installer can be seen on the first virtual terminal
Wait for at least 10 minutes. If you want to check if the installation is still running, run
```
ps ax | grep nand-sata-autoinstall
```
As long as this process is active, the installer is still running.
Once the installer has finished or 10 minutes have passed, power off the sbc, remove the sd card and boot from the internal emmc.
