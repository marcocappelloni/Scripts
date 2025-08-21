#!/bin/bash

color_critical="^c#FF0000^"
color_low="^c#FFA500^"
color_medium="^c#DDDD44^"
color_full="^c#44DD44^"
device=$(upower -e | grep battery_hidpp | sed 's:.*/battery_::')
capacity=$(cat /sys/class/power_supply/${device}/capacity_level)
status=$(cat /sys/class/power_supply/${device}/status | cut -c 1-4)
old_status_file="${HOME}/PersonalHome/Scripts/MyApps/keyboard_battery/low.txt"

#status="Charging"
#capacity="Unknown"

old_status="Low"

if [[ -f "$old_status_file" ]]; then
  read -r line <"$old_status_file"
  old_status="$line"
fi

#while IFS= read -r line; do
# # Process the line stored in the variable $line
#  echo "$line"
#done <"low.txt"

if [[ $status == "Charging" ]]; then
  echo "Full" >"$old_status_file"
  echo "${color_full}󱊦 "
  exit 0
fi

if [[ $capacity == "Unknown" ]]; then
  capacity="$old_status"
fi
#echo $was_already_low

# Case statement to determine which icon to display based on the status and capacity
case "$capacity" in
"Full")
  echo "Full" >"$old_status_file"
  echo "${color_full}󱊣 "
  ;;
"Normal")
  echo "Normal" >"$old_status_file"
  echo "${color_medium}󱊢 "
  ;;
"Low")
  echo "Low" >"$old_status_file"
  echo "${color_low}󱊡 "
  ;;
"Critical")
  echo "Critical" >"$old_status_file"
  echo "${color_critical}󱃍 "
  ;;
# Fallback for any other case
*)
  echo "${color_critical}󱉞 "
  ;;
esac
