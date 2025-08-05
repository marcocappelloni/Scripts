#!/bin/bash
# Script to install the applications passed through a text file specified
# as argument when you call the script.
# This script is called by base.sh

# Array to store applications that need to be installed
APPS_TO_INSTALL=()
APP_LIST_FILE="$1"

# Function to check if an application is installed
is_installed() {
  command -v "$1" &>/dev/null
}

is_in_repository() {
  apt-cache pkgnames | grep -q "$1"
}

install() {
  sudo apt update
  for app in "${APPS_TO_INSTALL[@]}"; do
    sudo apt install -y "$app"
  done
}

# echo "Insert the file with the list of the apps"
# read APP_LIST_FILE

# Check if the apps.txt file exists.
if [[ ! -f "$APP_LIST_FILE" ]]; then
  echo "Error: $APP_LIST_FILE not found."
  exit 1
fi

# Read applications from the file and check if they are installed.
while IFS= read -r app; do
  app=$(echo "$app" | tr -d '[:space:]') # Trim whitespace

  if [[ -n "$app" ]]; then # Skip empty lines

    if ! is_in_repository "$app"; then
      echo "WARNING: $app IS NOT IN THE REPOSITORY"
    else
      if ! is_installed "$app"; then
        APPS_TO_INSTALL+=("$app")
      else
        echo "$app is already installed."
      fi
    fi
  fi
done <"$APP_LIST_FILE"

# Install the applications that are not already installed.
if [[ ${#APPS_TO_INSTALL[@]} -gt 0 ]]; then
  echo "Installing the following applications: ${APPS_TO_INSTALL[*]}"
  echo "Procede? (Y/N)"
  read answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    install
  fi
else
  echo "All applications listed in $APP_LIST_FILE are already installed."
fi
