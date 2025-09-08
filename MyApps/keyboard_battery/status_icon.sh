#!/bin/bash

color_critical="^c#FF0000^"
color_low="^c#FFA500^"
color_medium="^c#DDDD44^"
color_full="^c#44DD44^"
device=$(upower -e | grep battery_hidpp | sed 's:.*/battery_::')
capacity=$(cat /sys/class/power_supply/${device}/capacity_level)
status=$(cat /sys/class/power_supply/${device}/status | cut -c 1-4)
old_status_file="${HOME}/PersonalHome/Scripts/MyApps/keyboard_battery/low.txt"

# Function to get the battery status from the percentage retrieved using upower
get_battery_status_from_percentage() {

  local percentage
  # Use upower to get the detailed info for the hidpp_battery_0 device
  # and use grep to find the line with "percentage"
  # then use awk to extract the number and remove the '%' sign.
  percentage=$(upower -i /org/freedesktop/UPower/devices/battery_hidpp_battery_0 |
    grep "percentage" |
    awk '{print int($2)}')

  # Check if the percentage was successfully retrieved
  if [ -z "$percentage" ]; then
    echo "N/A"
    return
  fi

  # Use a case statement to determine which icon to display based on the percentage
  case $percentage in
  # Full battery (75-100%)
  7[5-9] | [8-9][0-9] | [1][0][0])
    echo "Full"
    ;;
  # High battery (50-74%)
  [5-6][0-9] | 7[0-4])
    echo "Normal"
    ;;
  # Medium battery (25-49%)
  2[5-9] | [3-4][0-9])
    echo "Low"
    ;;
  # Low battery (0-24%)
  *)
    echo "Critical"
    ;;
  esac

}

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
if [[ $status == "Char" ]]; then

  echo "$(get_battery_status_from_percentage)" >"$old_status_file"
  echo "${color_full}󱊦 "
  exit 0
fi

if [[ $status == "Full" ]]; then

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
