# Description
This is the Alpha-1 release of an Armbian image doe OrangePi3-LTS, containing preconfigured packages for reticulum based networks. 

# Known Issues
Issue: Internal WiFi is not working
Workaround: Use USB WiFi

Issue: Serial output is not enabled
Workaround: Use display and keyboard

Issue: Not all features, like Sideband, have been tested
Workaround: Test and report issues ;)

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


# Usage
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

