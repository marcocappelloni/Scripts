#!/bin/bash

echo "Updating the system..."
sudo apt update && sudo apt upgrade

echo "Installing Flatpak..."
sudo apt install flatpak
# sudo apt install gnome-software-plugin-flatpak # install this package only if we are in gnome

echo "Adding the remote directory of the flathub repository///"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Reboot the system now? (Y/N)"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo reboot
fi
