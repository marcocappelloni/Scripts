#!/bin/bash


##### Variables #####
clonedirectory="https://github.com/marcocappelloni/dotfiles.git"

##### .dotfile directory #####
echo "Create and update the .dotfile directory?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    mkdir ~/.dotfiles
    git clone $clonedirectory -C $HOME
    echo "The directory .dotfiles has been created"
fi

##### Install stow and use it to create symlinks #####
sudo pacman -Syu
sudo pacman -S stow
stow --dir=~/.dotfiles --target=~/

echo "Reboot the system"
