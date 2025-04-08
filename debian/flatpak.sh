#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak # install this package only if we are in gnome

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

