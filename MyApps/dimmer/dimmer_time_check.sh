#!/usr/bin/env bash

source /home/maky/PersonalHome/Scripts/MyApps/dimmer/times_arrays.sh

# ------------------------------------------------------------------------------
# 2. Get the current month and select the correct array
# ------------------------------------------------------------------------------
current_month=$(date +%B)

# Read the times into an array
read -ra hours <<<"${times_by_month[$current_month]}"
# echo "month: $current_month"

# ------------------------------------------------------------------------------
# 3. Create a new array with times adjusted by one minute
# ------------------------------------------------------------------------------
declare -a hours_startup

for time in "${hours[@]}"; do
  # Convert time to epoch, subtract 60 seconds, and format back to time
  seconds=$(date -u -d "$time" +%s)
  adjusted_seconds=$((seconds - 60))
  adjusted_time=$(date -u -d "@$adjusted_seconds" +%H:%M)
  hours_startup+=("$adjusted_time")
done

currenttime=$(date +%H:%M)

if [[ "$currenttime" < "${hours_startup[0]}" ]]; then
  dimmer ${dimmer_parameters[3]} # 0.7 night
  exit 0
fi

if [[ "$currenttime" < "${hours_startup[1]}" ]]; then
  dimmer ${dimmer_parameters[0]} # 1
  exit 0
fi

if [[ "$currenttime" < "${hours_startup[2]}" ]]; then
  dimmer ${dimmer_parameters[1]} # 0.9
  exit 0
fi

if [[ "$currenttime" < "${hours_startup[3]}" ]]; then
  dimmer ${dimmer_parameters[2]} # 0.8 night
  exit 0
fi

#dimmer 0.7 night
dimmer ${dimmer_parameters[3]}
