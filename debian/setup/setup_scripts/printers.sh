#!/bin/bash

source ./utilities.sh

question "Would you like to install printing and scanning services? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing printing and scanning services..."
sudo apt install -y \
  cups cups-client cups-filters \
  cups-bsd sane sane-utils system-config-printer simple-scan
sudo apt install epson-inkjet-printer-escpr
sudo systemctl enable cups.service
sudo systemctl start cups.service

# Add current user to lpadmin group for printer admin rights
sudo usermod -aG lpadmin "$USER"

# Add current user to scanner group for scanner access
sudo usermod -aG scanner "$USER"
msg "Printing and scanning services installed."
