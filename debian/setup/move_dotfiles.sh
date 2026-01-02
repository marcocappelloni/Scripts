#!/bin/bash

cd ~/dotfiles

mkdir -p system extra bash dwm

mv .bashrc bash/

mv .inputrc .profile .xprofile .Xresources .Xresources.d/ system
mv bloodynight_colors.txt nimona_colors.txt extra

apps=("alacritty" "bash" "bat" "fastfetch" "ghostty" "helix" "i3" "kitty" "nvim" "polybar" "qtile" "rofi" "rofi_list" "yazi")

for app in "${apps[@]}"; do
  mkdir -p $app/.config
  mv .config/$app $app/.config/
done

mkdir -p picom/.config redshift/.config
mv .config/picom.conf picom/.config/picom.conf
mv .config/redshift.conf redshift/.config/redshift.conf

stowpackages=("system" "extra" "dwm" "alacritty" "bash" "bat" "fastfetch" "ghostty" "helix" "i3" "kitty" "nvim" "polybar" "qtile" "rofi" "rofi_list" "yazi")

for package in "${stowpackages[@]}"; do
  stow -D "$package" # Unstow first to avoid old link issues
  stow "$package"
done
