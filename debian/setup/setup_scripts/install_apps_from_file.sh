#!/bin/bash
# Script to install the applications passed through a text file specified
# as argument when you call the script.
# This script is called by base.sh

# Array to store applications that need to be installed
APPS_TO_INSTALL=()
APP_LIST_FILE="$1"

source "./utilities.sh"

# UPDATE THE SYSTEM
question "Do you want to update the system?"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo apt update && sudo apt upgrade -y && sudo apt autoclean
fi

# echo "Insert the file with the list of the apps"
# read APP_LIST_FILE

# Check if the apps.txt file exists.
if [[ ! -f "$APP_LIST_FILE" ]]; then
  die "$APP_LIST_FILE file not found."
fi

# Read applications from the file and check if they are installed.
while IFS= read -r app; do
  app=$(echo "$app" | tr -d '[:space:]') # Trim whitespace

  # Skip empty lines
  if [[ -z "$app" ]]; then
    continue
  fi

  if ! is_in_repository "$app"; then
    warning "$app is not in the repository"
    continue
  fi

  if is_installed "$app"; then
    warning "$app is already installed."
    continue
  fi

  APPS_TO_INSTALL+=("$app")

done <"$APP_LIST_FILE"

if [[ ${#APPS_TO_INSTALL[@]} -eq 0 ]]; then
  warning "There are no apps to install"
  exit 1
fi

# Install the applications that are not already installed.
msg "Installing the following applications: ${APPS_TO_INSTALL[*]}"
question "Procede? (Y/N)"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  install_packages "${APPS_TO_INSTALL[@]}"
fi
