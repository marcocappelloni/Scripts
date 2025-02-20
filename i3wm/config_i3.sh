#!/bin/bash

apps_file="./apps_list.txt"  # Path to your apps list file

# Configuring i3 wm partially following the website https://itsfoss.com/i3-customization/

# This first part is needed only if there is no any graphical environment installed otherwise are already installed
#sudo pacman -S xorg lightdm lightdm-gtk-greeter
#sudo systemctl enable lightdm.service
#sudo systemctl start lightdm.service

# Here start the first real part of installation of the i3 window manager and some package that are needed
#sudo pacman -S i3-wm i3lock i3status i3blocks autotiling dmenu alacritty


# --- Application Installation ---
echo "Installing applications..."

# Read application list from file
if [ ! -f "$apps_file" ]; then
  echo "Error: Application list file '$apps_file' not found."
  exit 1
fi

while IFS= read -r app; do
  app=$(echo "$app" | tr -d '[:space:]') # Remove leading/trailing whitespace
  if [[ ! -z "$app" ]]; then # Skip empty lines
      if command -v pacman &> /dev/null; then
          if ! pacman -S "$app" &> /dev/null; then
              echo "Error installing $app. Check if the package name is correct."
              exit 1
          else
            echo "Installed: $app"
          fi
      else
        echo "pacman not found.  This script is designed for Arch-based distributions."
        exit 1
      fi
  fi
done < "$apps_file"


cp config $HOME/.config/i3wm/
cp .Xresource $HOME/
cp -r .Xresource.d $HOME/
