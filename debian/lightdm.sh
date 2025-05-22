#!/bin/bash

service_active_and_enabled() {
  local service="$1"
  # Check if service is active and enabled
  sudo systemctl is-active --quiet "$service" && sudo systemctl is-enabled --quiet "$service"
}

if [ service_active_and_enabled lightdm ]; then
  echo "lightdm is already installed and enabled."
  exit 0
fi

sudo apt update
sudo apt install -y lightdm
sudo systemctl enable lightdm
