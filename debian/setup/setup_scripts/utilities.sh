#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Write a colored error message to the shell and exit from the script
die() {
  echo -e "${RED}ERROR: $*${NC}" >&2
  exit 1
}

# Write a colored error message to the shell
error() {
  echo -e "${RED}ERROR: $*${NC}" >&2
}

# Write a colored warning message to the shell
warning() {
  echo -e "${YELLOW}WARNING: $*${NC}" >&2
}

# Write a colored message to the shell
msg() { echo -e "${CYAN}$*${NC}"; }

question() { echo -e "${GREEN}$*${NC}"; }

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if an application is installed
is_installed() {
  dpkg -s "$1" &>/dev/null
}

# Check if an app is in the repository
is_in_repository() {
  apt-cache pkgnames | grep -q "$1"
}

# Install a list of apps passed as arguments
install_packages() {
  msg "--- Starting installation process ---"
  # "$@" expands to all positional parameters passed to the function,
  # safely quoted as separate words (e.g., "$1" "$2" "$3").
  for app in "$@"; do
    msg "Installing $app..."
    # Use -y for non-interactive installation
    sudo apt install -y "$app"
    if [ $? -ne 0 ]; then
      warning "Installation of '$app' failed."
    fi
  done
  msg "--- Installation process complete ---"
}
