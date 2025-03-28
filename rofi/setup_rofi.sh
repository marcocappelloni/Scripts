#!/bin/bash

##### Variables #####
clonedirectory="https://github.com/marcocappelloni/dotfiles.git"

# Clone dotfiles repository
echo "Create the .dotfile directory?"
read -rp "Y/n : " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    mkdir ~/.dotfiles
    git clone $clonedirectory -C ~/.dotfiles
    echo "The directory .dotfiles has been created"
fi


# Installation of rofi
echo "Install Rofi?"
read -rp "Y/n : " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo pacman -Syu
    sudo pacman -S rofi
    echo "Rofi installed."
fi

echo "Install JetBrains Mono Nerd Font"
