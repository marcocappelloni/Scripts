#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh

msg "Installing my version of dwm"
install_my_suckless "dwm"
msg "Installing my version of slstatus"
install_my_suckless "slstatus"
msg "Installing my version of dwmblocks-async"
install_my_suckless "dwmblocks-async"
