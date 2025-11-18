#!/bin/bash

source ./utilities.sh

question "Would you like to install Lightdm? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

service_active_and_enabled() {
  # Check if service is active and enabled
  sudo systemctl is-active --quiet lightdm && sudo systemctl is-enabled --quiet lightdm
}

if service_active_and_enabled; then
  warning "Lightdm is already installed and enabled."
  exit 0
fi

msg "Installing Lightdm..."
sudo apt install -y lightdm lightdm-settings slick-greeter
sudo systemctl enable lightdm
msg "Lightdm installed."
