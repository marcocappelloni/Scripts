#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

FONT_VERSION="v3.4.0"
FONTS_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/nerdfonts_install_$$" # Using PID to avoid conflicts

# Handle script interruption
cleanup() {
  warning "Script interrupted. Cleaning up..."
  rm -rf "$TEMP_DIR"
  exit 1
}

# Set the trap for SIGINT (Ctrl+C)
trap cleanup SIGINT

# Check if unzip is installed; if not, install it
if ! command_exists unzip; then
  msg "Installing unzip..."
  sudo apt install unzip -y
fi

# Check if wget is installed; if not, install it
if ! command_exists wget; then
  msg "Installing wget..."
  sudo apt install wget -y
fi

# Create directory for fonts if it doesn't exist
mkdir -p "$FONTS_DIR"
mkdir -p "$TEMP_DIR"

# Array of font names
fonts=(
  "CascadiaCode"
  "DejaVuSansMono"
  "FiraCode"
  "Hack"
  "Inconsolata"
  "JetBrainsMono"
  "Meslo"
  "Mononoki"
  "RobotoMono"
  "SourceCodePro"
  "UbuntuMono"
  # Add additional fonts here if needed
)

# Function to check if font directory exists
check_font_installed() {
  font_name=$1
  if [ -d "$FONTS_DIR/$font_name" ] && [ "$(ls -A "$FONTS_DIR/$font_name" 2>/dev/null)" ]; then
    warning "Font $font_name is already installed. Skipping."
    return 0 # Font already installed
  else
    return 1 # Font not installed
  fi
}

msg "Installing Nerd fonts..."
# Loop through each font, check if installed, and install if not
for font in "${fonts[@]}"; do

  if check_font_installed "$font"; then
    continue # Skip installation if font is already installed
  fi

  msg "Installing font: $font"
  wget --timeout=30 -q --show-progress "https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION}/${font}.zip" -P "$TEMP_DIR"
  if [ $? -ne 0 ]; then
    error "Failed to download font: $font"
    continue
  fi

  # Create font directory
  mkdir -p "$FONTS_DIR/$font"

  unzip -q "$TEMP_DIR/${font}.zip" -d "$FONTS_DIR/$font/"
  if [ $? -ne 0 ]; then
    error "Failed to extract font: $font"
    rm -rf "$FONTS_DIR/$font" # Clean up the incomplete font directory
    continue
  fi

  msg "Installed font $font"

  # Clean up the zip file
  rm -f "$TEMP_DIR/${font}.zip"

done

# Update font cache
msg "Updating the font cache..."
fc-cache -f

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

msg "Fonts installation completed."
