#!/bin/bash

sudo apt update %% sudo apt upgrade

sudo apt install network-manager-gnome

##### Start the applet to show on the systray #####
# Select the autostart file where to start the applet
selections=("DWM autostart" ".xinitrc")

echo "Where do you want to call the applet? (select the number):"
for i in "${!selections[@]}"; do
    echo "$((i+1)). ${selections[i]}"
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
        echo "Wrong selection!"
        ;;
esac

echo "The applet call will be added to: $autostart_path"

cat << EOF >> $autostart_path

nm-applet &

EOF
