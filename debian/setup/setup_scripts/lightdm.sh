#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

service_active_and_enabled() {
  # Check if service is active and enabled
  sudo systemctl is-active --quiet lightdm && sudo systemctl is-enabled --quiet lightdm
}

if service_active_and_enabled; then
  warning "Lightdm is already installed and enabled."
  exit 0
fi

msg "Installing Lightdm..."
sudo apt install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target
msg "Lightdm installed and enabled."
