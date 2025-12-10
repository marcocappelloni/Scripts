#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

# Check if picom is already installed
if command -v picom &>/dev/null; then
  warning "Picom is already installed. Skipping installation."
  exit 0
fi

# If picom is not installed, proceed with installation steps here
msg "Installing picom..."

# Add your installation commands here
# For example, if installing via apt (for Debian-based systems):
# sudo apt update
# sudo apt install -y picom

# Or if installing via another method, adjust accordingly

sudo apt install -y \
  libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev \
  libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev \
  libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev \
  libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev \
  libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev \
  libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev

git clone https://github.com/r0-zero/picom.git $HOME/packages/picom
cd $HOME/packages/picom
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install

msg "Picom installation completed."
