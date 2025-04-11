#!/bin/bash

# Script to install applications and update configuration files from lists.

timestamp=$(date +%Y%m%d_%H%M%S)
backup_dir="$HOME/dotfiles_backup/$timestamp"
apps_file="$HOME/apps.txt"  # Path to your apps list file
config_file_list="$HOME/config_files.txt" # Path to your config file list
dotfiles_dir="$HOME/dotfiles" #  <--- CHANGE THIS IF NEEDED.

# --- Configuration Backup ---
echo "Backing up current configuration..."
mkdir -p "$backup_dir"

# Function to backup files (handles both files and directories)
backup_file() {
  local file="$1"
  if [ -f "$HOME/$file" ] || [ -d "$HOME/$file" ]; then
    cp -r "$HOME/$file" "$backup_dir/$file"
    echo "Backed up: $file"
  else
    echo "Warning: $file not found, skipping backup."
  fi
}


# --- Application Installation ---

echo "Installing applications..."

# Read application list from file
if [ ! -f "$apps_file" ]; then
  echo "Error: Application list file '$apps_file' not found."
  exit 1
fi

while IFS= read -r app; do
  app=$(echo "$app" | tr -d '[:space:]') # Remove leading/trailing whitespace
  if [[ ! -z "$app" ]]; then # Skip empty lines
      if command -v pacman &> /dev/null; then
          if ! pacman -S --noconfirm "$app" &> /dev/null; then
              echo "Error installing $app. Check if the package name is correct."
              exit 1
          else
            echo "Installed: $app"
          fi
      else
        echo "pacman not found.  This script is designed for Arch-based distributions."
        exit 1
      fi
  fi
done < "$apps_file"


# --- Configuration Update ---

echo "Updating configuration files..."

# Read configuration file list from file
if [ ! -f "$config_file_list" ]; then
  echo "Error: Configuration file list '$config_file_list' not found."
  exit 1
fi


while IFS= read -r file; do
    file=$(echo "$file" | tr -d '[:space:]') # Remove leading/trailing whitespace
    if [[ ! -z "$file" ]]; then # Skip empty lines
        source_file="$dotfiles_dir/$file"
        destination_file="$HOME/$file"

        if [ -f "$source_file" ] || [ -d "$source_file" ]; then
            mkdir -p "$(dirname "$destination_file")"
            backup_file "$file" # Backup before overwriting
            cp -r "$source_file" "$destination_file"
            echo "Updated: $file"
        else
            echo "Warning: $source_file not found. Skipping."
        fi
    fi
done < "$config_file_list"

echo "Configuration update complete."


# --- Reload relevant services/shells ---
echo "Reloading relevant services/shells..."

if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
  echo "Reloaded .bashrc"
fi

if command -v i3-msg &> /dev/null; then
    i3-msg reload
    echo "Reloaded i3"
fi

echo "Script complete."
