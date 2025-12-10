#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing audio utilities..."
sudo apt install amixer pulseaudio pulseaudio-utils alsa-utils pavucontrol pamixer volumeicon
warning "configure volumeicon adding pulseaudio with the preference menu"
warning "Press enter to continue..."
read answer
msg "Audio utilities installed."
