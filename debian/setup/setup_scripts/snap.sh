#!/bin/bash

source ./utilities.sh

question "Would you like to install Snap? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing snap..."
sudo apt update
sudo apt install -y snapd
sudo snap install snapd
msg "Snap installed."
