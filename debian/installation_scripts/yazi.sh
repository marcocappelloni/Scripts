#!/bin/bash

# Setup the status for the script because it could need a logout
STATUS_FOLDER="$HOME/PersonalHome/Scripts/status"
CURRENT_STATE=$($STATUS_FOLDER/get_status.sh)

# First phase
if [[ "$CURRENT_STATE" -lt 1 ]]; then

  bash $STATUS_FOLDER/set_status.sh 1

  echo "Would you like to update the system and install the dependencies? (y/n)"
  read response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    # UPDATE APT
    echo "Updating the system..."
    sudo apt update && sudo apt upgrade
    # DEPENDENCIES
    echo "Installing the dependencies..."
    sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
  fi

  echo "Would you like to setup the latest stable Rust toolchain? (y/n)"
  read response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    # Setup the latest stable Rust toolchain via rustup
    echo "Setting up the latest stable Rust toolchain via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
    echo "Rebooting the system before continuing. When you will log back in restart the script!"
    echo "Press enter to reboot!"
    read response
    exit 0
  fi

fi

# Second phase
if [[ "$CURRENT_STATE" -eq 1 ]]; then

  bash $STATUS_FOLDER/reset_status.sh

  #BUILD FROM SOURCE
  # Clone the repository and build Yazi
  echo "Cloning and building yasi..."
  git clone https://github.com/sxyazi/yazi.git
  cd yazi
  cargo build --release --locked
  #Add yazi and ya to your PATH
  echo "Adding yazi and ya to the bin directory..."
  mv target/release/yazi target/release/ya $HOME/.local/bin/

fi
