#!/bin/bash

# Script to return the level of temperature of the GPU.
# It use the "sensors" command that is part of the "lm-sensors" package
# The script return:
# 0: if the temperature is not found
# 1: if the temperature level is LOW
# 2: if the temperature level is MEDIUM
# 3: if the temperature level is HIGH

GPU_STRING="amdgpu"
TEMP_LINE="edge:"
NUM_LINES=4
LOW_TEMP=45
MED_TEMP=80
HIGH_TEMP=95

# Run sensors command and store the output
SENSORS_OUTPUT=$(sensors)

GPU_TEMP=$(echo "$SENSORS_OUTPUT" | grep $GPU_STRING -A $NUM_LINES | grep $TEMP_LINE | awk '{print $2}' | tr -d '+' | tr -d '°C')

if [ -z "$GPU_TEMP" ]; then
  echo "0"
  exit 0
fi

RESULT=$(echo "$GPU_TEMP < $MED_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "1"
  exit 0
fi

RESULT=$(echo "$GPU_TEMP < $HIGH_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "2"
  exit 0
fi

echo "3"
