#!/bin/bash

# Script to install the catppuccin themes on rofi.
# Will be enabled the mocha one.
# To change it select another one in the config.rasi file
# Github website: "https://github.com/catppuccin/rofi"

$config_file=~/.config/rofi/config.rasi

git clone https://github.com/catppuccin/rofi.git

mkdir -p ~/.config/rofi
mkdir -p ~/.local/share/rofi/themes

mv ./rofi/basic/.config/rofi/config.rasi ~/.config/rofi
mv ./rofi/basic/.local/share/rofi/themes/catppuccin-frappe.rasi ~/.local/share/rofi/themes
mv ./rofi/basic/.local/share/rofi/themes/catppuccin-macchiato.rasi ~/.local/share/rofi/themes
mv ./rofi/basic/.local/share/rofi/themes/catppuccin-mocha.rasi ~/.local/share/rofi/themes

rm -rf ./rofi

echo "Do you want to append to the config.rasi file the settings for the rofi window size?"
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	exit 0
fi

echo "window{" >> $config_file
echo "	width: 40%;" >> $config_file
echo "	height: 50%;" >> $config_file
echo "}" >> $config_file
