#!/bin/bash

# Colors
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'
NC=$'\033[0m'

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

response_with_prompt() {
  local prompt="$1"
  local var_name="$2"
  read -p "${GREEN}${prompt}${NC}" input
  declare -g "$var_name=$input"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
  echo $?
}

# Check if an application is installed
is_installed() {
  dpkg -s "$1" &>/dev/null
  echo $?
}

# Check if an app is in the repository
is_in_repository() {
  apt-cache pkgnames | grep -q "$1"
  echo $?
}

install_single_app() {
  local app="$1"

  check=$(is_in_repository "$app")
  if [[ ! $check -eq 0 ]]; then
    warning "$app is not in the repository"
    return 1
  fi

  check=$(is_installed "$app")
  if [[ $check -eq 0 ]]; then
    warning "$app is already installed."
    return 1
  fi

  sudo apt -y install "$app"
  if [ $? -ne 0 ]; then
    warning "Installation of '$app' failed."
    return 1
  fi

  msg "$app installed!"
}

# Install a list of apps passed as arguments
install_packages() {
  msg "--- Starting installation package list ---"
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

install_my_suckless() {
  local package=$1
  msg "Installing my version of ${package}"
  cd $HOME/packages/suckless/$package
  rm ./config.h
  sudo make install
  cd -
  msg "Installed ${package}"
}

trimstring() {
  s="${1}"
  s="$(printf "${s}" | sed -z 's/^[[:space:]]*//')"
  s="$(printf "${s}" | sed -z 's/[[:space:]]*$//')"
  echo "${s}"
}

# Usage:
# array=(a b c d)
# array=($(remove_element "b" "${array[@]}"))
remove_element() {
  local target="$1"
  shift
  local arr=("$@")
  for i in "${!arr[@]}"; do
    if [[ "${arr[i]}" == "$target" ]]; then
      unset 'arr[i]'
      break
    fi
  done
  echo "${arr[@]}"
}
