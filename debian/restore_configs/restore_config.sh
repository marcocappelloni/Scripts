#!/bin/bash

##### Variables #####
clonedirectory="https://github.com/marcocappelloni/dotfiles.git"

##### .dotfile directory #####
echo "Create and update the dotfile directory?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  git clone $clonedirectory -C $HOME
  echo "The directory dotfiles has been created"
fi

##### Install stow and use it to create symlinks #####
sudo apt update && sudo apt upgrade
sudo apt install stow
stow --dir=~/.dotfiles --target=~/

echo "Reboot the system"
