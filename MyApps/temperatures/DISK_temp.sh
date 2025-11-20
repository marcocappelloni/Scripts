#!/bin/bash

# Script to return the level of temperature of the DISK.
# It use the "sensors" command that is part of the "lm-sensors" package
# The script return:
# 0: if the temperature is not found
# 1: if the temperature level is LOW
# 2: if the temperature level is MEDIUM
# 3: if the temperature level is HIGH

DISK_STRING="nvme"
TEMP_LINE="Composite"
NUM_LINES=2
LOW_TEMP=35
LOW_MED_TEMP=45
MED_TEMP=55
MED_HIGH_TEMP=60
HIGH_TEMP=65

# Run sensors command and store the output
SENSORS_OUTPUT=$(sensors)

DISK_TEMP=$(echo "$SENSORS_OUTPUT" | grep $DISK_STRING -A $NUM_LINES | grep $TEMP_LINE | awk '{print $2}' | tr -d '+' | tr -d '°C')

if [ -z "$DISK_TEMP" ]; then
  echo "0"
  exit 0
fi

RESULT=$(echo "$DISK_TEMP < $LOW_MED_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "1"
  exit 0
fi

RESULT=$(echo "$DISK_TEMP < $MED_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "2"
  exit 0
fi

RESULT=$(echo "$DISK_TEMP < $MED_HIGH_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "3"
  exit 0
fi

RESULT=$(echo "$DISK_TEMP < $HIGH_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "4"
  exit 0
fi

echo "5"
