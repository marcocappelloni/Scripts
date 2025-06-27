#!/usr/bin/env bash

## Spring
#hours=("05:59" "16:59" "18:59" "19:59")

# Summer
hours=("04:59" "17:59" "19:59" "20:59")

currenttime=$(date +%H:%M)

if [[ "$currenttime" < "${hours[0]}" ]]; then
  dimmer 0.7 night
  exit 0
fi

if [[ "$currenttime" < "${hours[1]}" ]]; then
  dimmer 1
  exit 0
fi

if [[ "$currenttime" < "${hours[2]}" ]]; then
  dimmer 0.9
  exit 0
fi

if [[ "$currenttime" < "${hours[3]}" ]]; then
  dimmer 0.8 night
  exit 0
fi

dimmer 0.7 night
  
done

