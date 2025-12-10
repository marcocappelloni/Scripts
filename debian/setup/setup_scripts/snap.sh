#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing snap..."
sudo apt update
sudo apt install -y snapd
sudo snap install snapd
msg "Snap installed."
