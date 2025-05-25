#!/bin/bash

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
  echo "LOGOUT before continue and restart the script skipping the first two steps!"
  exit 0
fi

#BUILD FROM SOURCE
# Clone the repository and build Yazi
echo "Cloning and building yasi..."
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked
#Add yazi and ya to your PATH
echo "Adding yazi and ya to the bin directory..."
mv target/release/yazi target/release/ya $HOME/.local/bin/
