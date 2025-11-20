#!/bin/bash

color_unknown="^c#FFA500^"
color_high="^c#FF0000^"
color_med_high="^c#EE6A21^"
color_med="^c#DDDD44^"
color_low_med="^c#AADCA2^"
color_low="^c#78DBFF^"

CPU_temp_level=$($HOME/PersonalHome/Scripts/MyApps/temperatures/CPU_temp.sh)
GPU_temp_level=$($HOME/PersonalHome/Scripts/MyApps/temperatures/GPU_temp.sh)
DISK_temp_level=$($HOME/PersonalHome/Scripts/MyApps/temperatures/DISK_temp.sh)

level=$CPU_temp_level
RESULT=$(echo "$GPU_temp_level > $level" | bc -l)
if [ "$RESULT" -eq 1 ]; then
  level=$GPU_temp_level
fi

RESULT=$(echo "$DISK_temp_level > $level" | bc -l)
if [ "$RESULT" -eq 1 ]; then
  level=$DISK_temp_level
fi

# If one the values is zero (didn't find the temperature value of one of the devices)
# then the
if [[ "$CPU_temp_level" == "0" ]] || [[ "$GPU_temp_level" == "0" ]] || [[ "$DISK_temp_level" == "0" ]]; then
  level="0"
fi

# Case statement to determine which icon to display based on the status and capacity
case "$level" in
"5")
  echo "${color_high}󱃂 "
  ;;
"4")
  echo "${color_med_high}󱃂 "
  ;;
"3")
  echo "${color_med}󱃂 "
  ;;
"2")
  echo "${color_low_med}󱃃 "
  ;;
"1")
  echo "${color_low} "
  ;;
# Fallback for any other case
*)
  echo "${color_unknown}󱔱 "
  ;;
esac
