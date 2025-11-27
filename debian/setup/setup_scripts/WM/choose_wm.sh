#!/bin/bash

source ../utilities.sh
source ./WM_utilities.sh

clear

INDEX=0

msg "CHOOSE WINDOWS MANAGERS"
msg "***********************"
msg "-) NONE"
msg "*) ALL"
for wm in ${WM_LIST[*]}; do
  INDEX=$((INDEX + 1))
  msg "$INDEX) $wm"
done
msg "***********************"
msg " "
question "LIST ONE OR MORE CHOICES SEPARATED BY SPACE (example: 1 2)"
response_with_prompt "Choice: " response

if [[ "$response" == "-" ]]; then
  response=""
fi

if [[ "$response" == "*" ]]; then

  INDEX=0
  response=""
  for wm in ${WM_LIST[*]}; do
    INDEX=$((INDEX + 1))
    response+="$INDEX "
  done

fi

response=$(trimstring "$response")

# WMS_ARRAY=($response)
#
# echo "Array: ${WMS_ARRAY[*]}"
# echo "Elemen 1: ${WMS_ARRAY[0]}"
# echo "Elemen 2: ${WMS_ARRAY[1]}"
# echo "Number: ${#WMS_ARRAY[@]}"

./install_WMS.sh "$response"
