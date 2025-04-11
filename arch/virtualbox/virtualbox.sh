#!/bin/bash


echo "Update the system first?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo pacman -Syu
fi

sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso

sudo modprobe vboxdrv
