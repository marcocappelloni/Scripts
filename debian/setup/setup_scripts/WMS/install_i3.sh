#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh

I3_PACKAGES=(
  "autotiling"
  "i3-wm"
  "i3blocks"
)

msg "Installing i3WM packages"
for package in ${I3_PACKAGES[*]}; do
  install_packages "${I3_PACKAGES[@]}"
done
