#!/bin/bash

cd ~/dotfiles

mkdir -p system extra bash dwm

mv .bashrc bash/

mv .inputrc .profile .xprofile .Xresources .Xresources.d/ system
mv bloodynight_colors.txt nimona_colors.txt extra

mkdir -p bash/.config
mv .config/bash bash/.config/

apps=("alacritty" "bash" "bat" "fastfetch" "ghostty" "helix" "i3" "kitty" "nvim" "polybar" "qtile" "rofi" "rofi_list" "yazi" "tmux" "zsh")

for app in "${apps[@]}"; do
  mkdir -p $app/.config
  mv .config/$app $app/.config/
done

mkdir -p picom redshift
mv .config/picom.conf picom/.config
mv .config/redshift.conf redshift/.config
