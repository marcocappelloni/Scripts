#!/bin/bash


##### Variables #####
clonedirectory="https://github.com/marcocappelloni/dotfiles.git"

sudo apt update && sudo apt upgrade
sudo apt install git

##### .dotfile directory #####
echo "Create and update the .dotfile directory?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    mkdir $HOME/.dotfiles
    git clone $clonedirectory -C $HOME
    echo "The directory .dotfiles has been created"
fi

sudo apt install stow
stow --dir=$HOME/.dotfiles --target=$HOME

echo "Reboot the system"
