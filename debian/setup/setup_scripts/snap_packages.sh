#!/bin/bash

source ./utilities.sh

question "Would you like to install the snap packages? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing Snap packages"

# Bookmarks manager
sudo snap install raindrop
# Pomodoro timer
# sudo snap install pomatez

msg "Snap packages installed."
