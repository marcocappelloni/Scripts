#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing Bluetooth services..."
sudo apt install -y bluez blueman bluez-tools pulseaudio-module-bluetooth || die "Failed to install bluetooth"
# Enable and start Bluetooth service
sudo systemctl enable bluetoothi.service
sudo systemctl start bluetooth.service
# Add current user to bluetooth group
sudo usermod -aG bluetooth "$USER"
msg "Bluetooth services installed."
