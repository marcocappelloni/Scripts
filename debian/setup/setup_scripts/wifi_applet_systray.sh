#!/bin/bash

source ./utilities.sh

question "Would you like to install the wifi applet for the systray in the status bar? (y/n)"
read response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  exit 0
fi

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

autostart_path=""

case "$selection" in
1)
  autostart_path="~/.dwm/autostart.sh"
  ;;
2)
  autostart_path="~/.xinitrc"
  ;;
*)
  die "Wrong selection!"
  ;;
esac

msg "The applet call will be added to: $autostart_path"

cat <<EOF >>$autostart_path

nm-applet &

EOF

msg "Wifi applet installed."
