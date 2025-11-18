#!/bin/bash

source ./utilities.sh

question "Would you like to install Bluetooth services? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing Bluetooth services..."
sudo apt install -y bluez blueman bluez-tools pulseaudio-module-bluetooth || die "Failed to install bluetooth"
# Enable and start Bluetooth service
sudo systemctl enable bluetoothi.service
sudo systemctl start bluetooth.service
# Add current user to bluetooth group
sudo usermod -aG bluetooth "$USER"
msg "Bluetooth services installed."
