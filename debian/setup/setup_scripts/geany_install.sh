#!/usr/bin/env bash

# Author: Marco Cappelloni
# Script to install Geany with the main plugins and some colorschemes

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing Geany"

# Update and upgrade the system
# sudo apt update && sudo apt upgrade

# Install Geany
sudo apt install -y geany

# Install the main plugins
sudo apt install geany-plugin-addons geany-plugin-git-changebar geany-plugin-spellcheck geany-plugin-treebrowser geany-plugin-vimode geany-plugin-markdown

# Destination folder for the color color schemes
SCHEME_FOLDER="~/.config/geany/colorschemes"

# Create, if it doesn't exist, the directory where to save the colorschemes
mkdir -p "$SCHEME_FOLDER"

# Download all the themes that I chosen in the correct destination folder
wget -P "$SCHEME_FOLDER" "https://raw.github.com/geany/geany-themes/master/colorschemes/kary-pro-colors-dark.conf"
wget -P "$SCHEME_FOLDER" "https://raw.github.com/geany/geany-themes/master/colorschemes/one-dark.conf"
wget -P "$SCHEME_FOLDER" "https://raw.github.com/geany/geany-themes/master/colorschemes/underthesea.conf"
wget -P "$SCHEME_FOLDER" "https://raw.github.com/geany/geany-themes/master/colorschemes/zenburn.conf"
wget -P "$SCHEME_FOLDER" "https://raw.githubusercontent.com/catppuccin/geany/refs/heads/main/src/catppuccin-frappe.conf"
wget -P "$SCHEME_FOLDER" "https://raw.githubusercontent.com/catppuccin/geany/refs/heads/main/src/catppuccin-macchiato.conf"
wget -P "$SCHEME_FOLDER" "https://raw.githubusercontent.com/catppuccin/geany/refs/heads/main/src/catppuccin-mocha.conf"

msg "Geany installed"
