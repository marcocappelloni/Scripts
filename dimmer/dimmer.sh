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

# My monitors (use xrandr to check the names)
M1="HDMI-A-0"
M2="HDMI-A-1"

notif() {
  notify-send -t 3000 "Brightness adjusted!"
}

[ "$2" = night ] && gamma="1.0:0.95:0.85" || gamma="1.0:1.0:1.0"

xrandr --output "$M1" --brightness "$1" --gamma "$gamma"
xrandr --output "$M2" --brightness "$1" --gamma "$gamma"
notif
