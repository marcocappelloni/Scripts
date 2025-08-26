#!/bin/bash

# Function to print a progress bar.
# The function takes 2 arguments:
# Argument 1: index of the current command executed
# Argument 2: total number of commands to be executed

BAR_CHAR='|'
EMPTY_CHAR='.'
START_CHAR='['
END_CHAR=']'
LENGTH_BAR=50
BAR_COLOR='\e[33m'
RESET_COLOR='\e[0m'

progress-bar() {
  local current=$1
  local len=$2

  local perc_done=$((current * 100 / len))
  local num_bars=$((perc_done * $LENGTH_BAR / 100))

  local i
  local string_bar=$START_CHAR

  for ((i = 0; i < num_bars; i++)); do
    string_bar+="${BAR_COLOR}"$BAR_CHAR"$RESET_COLOR"
  done

  for ((i = num_bars; i < $LENGTH_BAR; i++)); do
    string_bar+=$EMPTY_CHAR
  done

  string_bar+=$END_CHAR

  echo -ne "$string_bar $current/$len ($perc_done%)\r"
}
