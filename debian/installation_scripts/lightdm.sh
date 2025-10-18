#!/bin/bash

service_active_and_enabled() {
  # Check if service is active and enabled
  sudo systemctl is-active --quiet lightdm && sudo systemctl is-enabled --quiet lightdm
}

if service_active_and_enabled; then
  echo "lightdm is already installed and enabled."
  exit 0
fi

sudo apt update
sudo apt install -y lightdm lightdm-settings slick-greeter
sudo systemctl enable lightdm
