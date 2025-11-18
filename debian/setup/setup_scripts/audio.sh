#!/bin/bash

source ./utilities.sh

question "Would you like to install audio utilities? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

msg "Installing audio utilities..."
sudo apt install amixer pulseaudio pulseaudio-utils alsa-utils pavucontrol pamixer volumeicon
warning "configure volumeicon adding pulseaudio with the preference menu"
msg "Audio utilities installed."
