#!/bin/bash

STATE_FILE="actual_state.txt"
CURRENT_STATE=0

if [[ -f "$STATE_FILE" ]]; then
  CURRENT_STATE=$(cat "$STATE_FILE")
fi

echo $CURRENT_STATE
