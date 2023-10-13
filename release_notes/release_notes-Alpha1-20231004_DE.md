Neueste Version dieses Dokuments: https://github.com/greygoo/disk-image/blob/main/release_notes/release_notes_DE-20231004.md

# Beschreibung
Dies ist die Alpha-1-Version eines Armbian Image fuer den OrangePi3-LTS, das vorkonfigurierte Pakete für Retikulum-basierte Netzwerke enthält.

# Bekannte Probleme
Problem: Internes WLAN funktioniert nicht
Problemumgehung: Verwenden Sie USB-WLAN

Problem: Die serielle Ausgabe ist nicht aktiviert
Problemumgehung: Verwenden Sie Display und Tastatur

Problem: Nicht alle Funktionen, wie z. B. Sideband, wurden getestet
Problemumgehung: Funktionen testen und melden ;)

# Aufbau
- Standardbenutzer: `nomad`
- Standardpasswort: `nomad`

# Inhalt
## Armbian
Die Basis ist ein Armbian-Minimal-Build mit der folgenden Konfiguration:
- BRANCH `current` 
- RELEASE `ubuntu jammy`

## Reticulum
Reticulum wird als Python-Paket geliefert und im Home-Bereich des Benutzers `nomad` installiert. Dem System werden zwei systemd Dienstdateien hinzugefügt, die den RNS-Dienst und die Befehlszeilen-App `nomadnet` in einer Bildschirmsitzung für den Benutzer `nomad` starten. Außerdem ist eine GUI-Anwendung namens `Sideband` installiert, die vom Desktop aus gestartet werden kann.

### Reticulum Python-Pakete
- rns
- lxmf
- nomadnet
- Anfragen
- sbapp

### Reticulum-Servicedateien
- /etc/systemd/system/rnsd.service
- /etc/systemd/system/nomadnet.service

## Andere installierte Debian-Pakete

### Anforderungen für RNS
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

### Konsolentools
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
1. Legen Sie eine Micro-SD-Karte in den Computer ein, auf den Sie das Image heruntergeladen haben
2. Bestimmen Sie das SD-Kartengerät
```
lsblk
```
3. Image auf SD-Karte schreiben
```
sudo dd if=output/images/Armbian_23.08.0-trunk_Orangepi3-lts_jammy_current_6.1.55_minimal.img of=<SD-Kartengeraet > bs=1M oflag=sync status=progress
```
4. Legen Sie die Micro-SD-Karte in den Orange Pi 3 LTS ein und schließen Sie ihn an die Stromversorgung an


# Verwendung
## Nomadnet
- Mit laufender Sitzung verbinden, als Benutzer nomad ausführen:
```
screen -x
```

- Trennen:
`STRG+a+d`

**Hinweis:** Diese Sitzung wird beim Booten für den Benutzer gestartet, damit sie ohne angeschlossenes Display ausgefuehrt wird. Wenn Sie diese Instanz beenden, können Sie NomadNet jederzeit durch Ausführen neu starten
```
nomadnet
```

## Sideband 
TODO

## Auf Werkseinstellungen zuruecksetzen 
**HINWEIS** Bei einem Zurücksetzen auf die Werkseinstellungen werden alle Änderungen, die Sie bisher am System vorgenommen haben, gelöscht!
Das Image ist mit btrfs konfiguriert und verfügt über einen Snapshot des Status nach dem ersten Start. Um das Gerät zurückzusetzen, führen Sie Folgendes aus:
```
factory-reset
```

## LoRa-Konfiguration
Um die Einstellungen für Ihr verbundenes LoRa-Gerät zu ändern, führen Sie bitte Folgendes aus
```
lora_config.sh
```
