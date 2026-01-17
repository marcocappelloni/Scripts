#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing the wifi applet..."
sudo apt install network-manager-gnome

##### Start the applet to show on the systray #####
# Select the autostart file where to start the applet
selections=("DWM autostart" ".xinitrc")

question "Where do you want to call the applet? (select the number):"
for i in "${!selections[@]}"; do
  question "$((i + 1)). ${selections[i]}"
done
read -rp "Selection: " selection

FILE=""

case "$selection" in
1)
  FILE="$HOME/.dwm/autostart.sh"
  ;;
2)
  FILE="$HOME/.xinitrc"
  ;;
*)
  die "Wrong selection!"
  ;;
esac

msg "The applet call will be added to: $FILE"

LINE="nm-applet &"

# Ensure the file exists
touch "$FILE"

# Only append if the line isn't already there
grep -qxF "$LINE" "$FILE" || echo "$LINE" >>"$FILE"

msg "Wifi applet installed."
