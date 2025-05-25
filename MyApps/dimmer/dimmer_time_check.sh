#!/usr/bin/env bash

currenttime=$(date +%H:%M)

if [[ "$currenttime" < "05:59" ]]; then
  dimmer 0.7 night
  exit 0
fi

if [[ "$currenttime" < "16:59" ]]; then
  dimmer 1
  exit 0
fi

if [[ "$currenttime" < "18:59" ]]; then
  dimmer 0.9
  exit 0
fi

if [[ "$currenttime" < "19:59" ]]; then
  dimmer 0.8 night
  exit 0
fi

dimmer 0.7 night
