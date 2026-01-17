#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

question "Would you like to activate the process to create the symbolic link to my dotfiles with stow? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

bash /home/maky/dotfiles/mystow.sh
