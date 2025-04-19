#!/bin/bash

# Check if the script is being run interactively (from the terminal)
if [[ -t 0 ]]; then
  echo "Insert the file with the list of the apps"
  read APP_LIST_FILE
else
  # If not interactive, assume the file name is passed as an argument
  APP_LIST_FILE="$1"
fi

# Array to store applications that need to be installed
APPS_TO_INSTALL=()

# Function to check if an application is installed
is_installed() {
  command -v "$1" &> /dev/null
}

# Check if the apps.txt file exists.
if [[ ! -f "$APP_LIST_FILE" ]]; then
  echo "Error: $APP_LIST_FILE not found."
  exit 1
fi

# Read applications from the file and check if they are installed.
while IFS= read -r app; do
  app=$(echo "$app" | tr -d '[:space:]') # Trim whitespace

  if [[ -n "$app" ]]; then # Skip empty lines
    if ! is_installed "$app"; then
        APPS_TO_INSTALL+=("$app")
    else
      echo "$app is already installed."
    fi
  fi
done < "$APP_LIST_FILE"

echo "${APPS_TO_INSTALL[@]}"
