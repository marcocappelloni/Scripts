#!/usr/bin/env bash

THEME_DIR="$HOME/.Xresources.d/themes"
XCONF="$HOME/.Xresources"

# 1. Get list of files and strip the .Xresources extension for a cleaner dmenu list
SELECTED=$(ls "$THEME_DIR" | sed 's/\.Xresources//' | dmenu -l 15 -i -p "System Theme:")

[ -z "$SELECTED" ] && exit 0

# 2. Use sed to replace the include line.
# This looks for any line starting with #include and pointing into your themes folder
sed -i "s|#include \".Xresources.d/themes/.*\"|#include \".Xresources.d/themes/$SELECTED.Xresources\"|" "$XCONF"

# 3. Reload Xresources
xrdb -merge "$XCONF"

# 4. Refresh bspwm borders & Polybar (via your bspwmrc)
bash "$HOME/.config/bspwm/bspwmrc" >/dev/null 2>&1 &

# 5. Live-update open terminals
"$HOME/PersonalHome/Scripts/MyApps/theme_switch/refresh_terminals.sh" >/dev/null 2>&1 &

notify-send "Global Theme Applied" "Switched to $SELECTED"
