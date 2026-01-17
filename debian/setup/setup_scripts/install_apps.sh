#!/usr/bin/env bash

# Script to install the applications passed through an array passed
# as argument when you call the script.

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

APP_LIST=($1)
# Array to store applications that need to be installed
APPS_TO_INSTALL=()

question "Do you want to update the system?"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo apt update && sudo apt upgrade -y && sudo apt autoclean
fi

for app in ${APP_LIST[*]}; do

  check=$(is_in_repository "$app")
  if [[ ! $check -eq 0 ]]; then
    warning "$app is not in the repository"
    continue
  fi

  check=$(is_installed "$app")
  if [[ $check -eq 0 ]]; then
    warning "$app is already installed."
    continue
  fi

  APPS_TO_INSTALL+=("$app")

done

if [[ ${#APPS_TO_INSTALL[@]} -eq 0 ]]; then
  warning "There are no apps to install"
  exit 1
fi

# Install the applications that are not already installed.
msg "Installing the following applications: \n${APPS_TO_INSTALL[*]}"
question "Procede? (Y/N)"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  install_packages "${APPS_TO_INSTALL[@]}"
fi
