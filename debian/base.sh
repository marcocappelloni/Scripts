#!/bin/bash

echo ""
su

apt install sudo
usermod -aG sudo maky
reboot

apt install git micro
apt install xorg xserver-xorg

su maky

sudo apt install lxappearance pcmanfm nitrogen chromium kitty network-manager
sudo apt install geany build-essential cmake
sudo apt install p7zip p7zip-full unrar-free unzip
