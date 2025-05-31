#!/bin/bash

# Author: Marco Cappelloni
# Script to adjust the brightness and the gamma of the colors of the monitors.
# This script will be called at certain time by cron.
# Call this script with one or two parameters:
# The first one is the percentage of brightness (0..1)
# The second one (optional) is the string "night" that is used to change
# the gamma of the colors as well

# Without this variable cron will get confused where to run this script
export DISPLAY=:0

notif() {
  notify-send -t 3000 "Brightness adjusted!"
}

[ "$2" = night ] && gamma="1.0:0.95:0.85" || gamma="1.0:1.0:1.0"

dimm() {
  monitors=$(xrandr | grep "connected" | cut -d ' ' -f 1)
  while read monitor; do
    xrandr --output $monitor --brightness "$1" --gamma "$gamma"
  done <<<"$monitors"
}

dimm && notif
