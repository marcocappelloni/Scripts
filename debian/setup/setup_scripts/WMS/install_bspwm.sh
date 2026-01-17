#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh

BSPWM_PACKAGES=(
  "bspwm"
  "polybar"
)

msg "Installing bspwm packages"
install_packages "${BSPWM_PACKAGES[@]}"
