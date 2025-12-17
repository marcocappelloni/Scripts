#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing Flatpak..."
sudo apt install flatpak -y
# sudo apt install gnome-software-plugin-flatpak # install this package only if we are in gnome

msg "Adding the remote directory of the flathub repository"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

warning "Before using Flatpak you will need to reboot the system."
warning "Push enter to continue..."
read answer

msg "Flatpak installed."
