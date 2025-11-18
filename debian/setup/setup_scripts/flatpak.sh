#!/bin/bash

source ./utilities.sh

question "Would you like to install Flatpak? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing Flatpak..."
sudo apt install flatpak
# sudo apt install gnome-software-plugin-flatpak # install this package only if we are in gnome

msg "Adding the remote directory of the flathub repository"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

warning "Before using Flatpak you will need to reboot the system."
msg "Flatpak installed."
