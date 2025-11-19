#!/bin/bash

# Script to return the level of temperature of the CPU.
# It use the "sensors" command that is part of the "lm-sensors" package
# The script return:
# 0: if the temperature is not found
# 1: if the temperature level is LOW
# 2: if the temperature level is MEDIUM
# 3: if the temperature level is HIGH

CPU_STRING="k10temp"
TEMP_LINE="Tctl"
NUM_LINES=2
LOW_TEMP=40
MED_TEMP=70
HIGH_TEMP=90

# Run sensors command and store the output
SENSORS_OUTPUT=$(sensors)

# 1. CPU Temperature (k10temp)
# Tctl is the thermal control temperature for AMD CPUs
CPU_TEMP=$(echo "$SENSORS_OUTPUT" | grep $CPU_STRING -A $NUM_LINES | grep $TEMP_LINE | awk '{print $2}' | tr -d '+' | tr -d '°C')

if [ -z "$CPU_TEMP" ]; then
  echo "0"
  exit 0
fi

RESULT=$(echo "$CPU_TEMP < $MED_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "1"
  exit 0
fi

RESULT=$(echo "$CPU_TEMP < $HIGH_TEMP" | bc -l)

if [ "$RESULT" -eq 1 ]; then
  echo "2"
  exit 0
fi

echo "3"
