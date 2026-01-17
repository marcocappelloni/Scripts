#!/usr/bin/env bash

cd ~/dotfiles

mkdir -p system bash dwm

mv .bashrc bash/

mv .inputrc .profile .xprofile .Xresources .Xresources.d/ system
#mv bloodynight_colors.txt nimona_colors.txt extra

apps=("alacritty" "bash" "bat" "fastfetch" "ghostty" "helix" "i3" "kitty" "nvim" "polybar" "qtile" "rofi" "rofi_list" "yazi")

for app in "${apps[@]}"; do
  mkdir -p $app/.config
  mv .config/$app $app/.config/
done

mkdir -p picom/.config redshift/.config dwm
mv .config/picom.conf picom/.config/picom.conf
mv .config/redshift.conf redshift/.config/redshift.conf
mv .dwm dwm/

rm -r .config/
