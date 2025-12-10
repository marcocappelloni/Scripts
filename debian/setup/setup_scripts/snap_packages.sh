#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing Snap packages"

# Bookmarks manager
msg "Installing raindrop..."
sudo snap install raindrop
# Pomodoro timer
# sudo snap install pomatez

msg "Snap packages installed."
