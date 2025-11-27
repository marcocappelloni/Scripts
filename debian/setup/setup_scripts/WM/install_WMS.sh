#!/bin/bash

source ../utilities.sh
source ./WM_utilities.sh

WM_CHOSEN=($1)

msg "Array chosen: ${WM_CHOSEN[*]}"

for INDEX in ${WM_CHOSEN[*]}; do
  case "${WM_LIST[$((INDEX - 1))]}" in
  "DWM")
    bash ./install_dwm.sh
    ;;
  "I3WM")
    bash ./install_i3.sh
    ;;
  "QTILE")
    echo "Install qtile"
    ;;
  *)
    echo "WM not recognised"
    ;;
  esac
done
