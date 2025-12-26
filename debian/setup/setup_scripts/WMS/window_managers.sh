#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh
source $SCRIPT_PATH/../variables.sh

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

WM_CHOSEN=$(trimstring "$response")

# WMS_ARRAY=($response)
#
# echo "Array: ${WMS_ARRAY[*]}"
# echo "Elemen 1: ${WMS_ARRAY[0]}"
# echo "Elemen 2: ${WMS_ARRAY[1]}"
# echo "Number: ${#WMS_ARRAY[@]}"

#./install_WMS.sh "$response"

#source ../utilities.sh
#source ./WM_utilities.sh

#WM_CHOSEN=($1)

msg "Array chosen: ${WM_CHOSEN[*]}"

for INDEX in ${WM_CHOSEN[*]}; do
  case "${WM_LIST[$((INDEX - 1))]}" in
  "DWM")
    $SCRIPT_PATH/install_dwm.sh
    ;;
  "I3WM")
    $SCRIPT_PATH/install_i3.sh
    ;;
  "QTILE")
    msg "Install fake qtile"
    ;;
  *)
    error "WM not recognised"
    ;;
  esac
done
