#!/bin/bash

apps_file="./apps_list.txt"  # Path to your apps list file

# String to store the apps that are not installed
not_installed_apps=""


# This first part is needed only if there is no any graphical environment installed otherwise are already installed
#sudo pacman -S xorg lightdm lightdm-gtk-greeter
#sudo systemctl enable lightdm.service
#sudo systemctl start lightdm.service

# SYSTEM UPDATE
echo "System update..."
sudo pacman -Syu


# --- Application Installation ---
echo "Installing applications..."

# Read application list from file
if [ ! -f "$apps_file" ]; then
  echo "Error: Application list file '$apps_file' not found."
  exit 1
fi

# Loop through each app in the list
while IFS= read -r app; do
    app=$(echo "$app" | tr -d '[:space:]') # Remove leading/trailing whitespace
    if [[ ! -z "$app" ]]; then # Skip empty lines
        # Check if the app is installed
        if ! pacman -Qs "^${app}\$" &> /dev/null; then
            # If not installed, append it to the string
            not_installed_apps="$not_installed_apps $app"
        fi
    fi
done < "$apps_file"

# Remove leading space from the string
not_installed_apps="${not_installed_apps#" "}"

# Print the string of not installed apps
if [[ -n "$not_installed_apps" ]]; then
    sudo pacman -S $not_installed_apps
else
  echo "All apps in the list are already installed."
fi

mkdir -p $HOME/.config/qtile
cp config.py $HOME/.config/qtile/
cp -r rofi $HOME/.config/qtile/
cp -r scripts $HOME/.config/qtile/
cp -r settings $HOME/.config/qtile/
cp -r sxhkd $HOME/.config/qtile/
cp -r themes $HOME/.config/qtile/

