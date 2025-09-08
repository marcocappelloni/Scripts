#!/bin/bash

old_status_file="${HOME}/PersonalHome/Scripts/MyApps/keyboard_battery/temp.txt"

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

echo "$(get_battery_status_from_percentage)" >"$old_status_file"
