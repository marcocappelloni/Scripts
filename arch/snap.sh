#!/bin/bash

# Installation of snap

sudo pacman -Syu
yay -Syu
sudo pacman -S base-devel
yay -S snapd
sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo systemctl enable --now snapd.apparmor
sudo ln -s /var/lib/snapd/snap /snap
