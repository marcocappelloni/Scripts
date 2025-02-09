#!/bin/sh

sudo apt update
sudo apt upgrade

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak # install this package only if we are in gnome

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo apt remove firefox-esr # remove firefox to install the flatpak version

#activate first the non-free software repository
sudo apt install libavcodec-extra vlc

sudo nano /etc/apt/sources.list.d/backports.list
# add the line:
# deb http://deb.debian.org/debian bookworm-backports main
# to install a package from this repository:
# sudo apt install -t bookworm-backports package-name

# another software manager (don't have flatpack)
sudo apt install synaptic

sudo apt install autotiling
sudo apt install picom-conf
