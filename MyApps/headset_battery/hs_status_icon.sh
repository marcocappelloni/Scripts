#!/usr/bin/env bash

icon_full="󰋋-󱊣"
icon_medium="󰋋-󱊢"
icon_low="󰋋-󱊡"
icon_critical="󰋋-󱃍"
icon_disconnected="󰟎"

color_disconnected="^c#7F849C^"
color_critical="^c#FF0000^"
color_low="^c#FFA500^"
color_medium="^c#DDDD44^"
color_full="^c#44DD44^"

dev=$(upower -e | grep -i 'headset' | head -n 1)
mac=$(echo "$dev" | grep -oE '([0-9A-Fa-f]{2}_){5}[0-9A-Fa-f]{2}' | tr '_' ':')

# Disconnected or missing device -> gray icon
if [ -z "$dev" ] || [ -z "$mac" ] || ! bluetoothctl devices Connected | grep -qi "$mac"; then
  echo "${color_disconnected}${icon_disconnected}"
  exit 0
fi

# Extract numeric percentage (strips trailing '%')
pct=$(upower -i "$dev" | awk '/percentage:/ {gsub(/%/, "", $2); printf "%d", $2}')

if [ -z "$pct" ]; then
  echo "${color_disconnected}${icon_disconnected}$"
  exit 0
fi

if [ "$pct" -ge 75 ]; then
  echo "${color_full}${icon_full}"
elif [ "$pct" -ge 50 ]; then
  echo "${color_medium}${icon_medium}"
elif [ "$pct" -ge 25 ]; then
  echo "${color_low}${icon_low}"
else
  echo "${color_critical}${icon_critical}"
fi

#echo "${color}${icon}"
