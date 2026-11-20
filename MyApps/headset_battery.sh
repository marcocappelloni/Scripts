#!/usr/bin/env bash

dev=$(upower -e | grep -i 'headset' | head -n 1)
mac=$(echo "$dev" | grep -oE '([0-9A-Fa-f]{2}_){5}[0-9A-Fa-f]{2}' | tr '_' ':')

if [ -n "$dev" ] && [ -n "$mac" ] && bluetoothctl devices Connected | grep -qi "$mac"; then
  upower -i "$dev" | awk '/percentage:/ {print $2}'
else
  echo "Disconnected"
fi
