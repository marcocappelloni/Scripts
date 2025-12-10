#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh

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

question "Do you want to install driver and utility for an epson printer? (Y/N):"
read answer
if [[ ! "$answer" =~ ^[Y/y]$ ]]; then
  bash $SCRIPT_PATH/epson.sh
fi
