#!/bin/bash

# Define the keywords and their corresponding configuration file paths
declare -A config_files=(
  ["autostart"]="$HOME/.dwm/autostart.sh"
  ["bashrc"]="$HOME/.bashrc"
  ["bash aliases"]="$HOME/.bash_aliases"
  ["dwm config"]="$HOME/packages/suckless/dwm/config.def.h"
  ["dmenu config"]="$HOME/packages/suckless/dmenu/config.def.h"
  ["slstatus config"]="$HOME/packages/suckless/slstatus/config.def.h"
  ["kitty config"]="$HOME/.config/kitty/kitty.conf"
  ["neovim config"]="$HOME/.config/nvim/init.lua"
  ["picom config"]="$HOME/.config/picom.conf"
  ["rofi config"]="$HOME/.config/rofi/config.rasi"
  # Add more keywords and file paths as needed
)

# Generate the list of keywords for dmenu
keywords=$(printf '%s\n' "${!config_files[@]}" | sort)

# Open dmenu and get the user's selection
selected_keyword=$(echo "$keywords" | dmenu -i -l 10 -p "Edit Config:")

# Check if a keyword was selected
if [ -n "$selected_keyword" ]; then
  # Get the corresponding configuration file path
  config_file="${config_files["$selected_keyword"]}"

  # Check if the configuration file exists
  if [ -f "$config_file" ]; then
    # Open the configuration file in neovim in a new kitty window
    kitty --start-as=normal nvim "$config_file"
  else
    echo "Error: Configuration file not found: $config_file" >&2
  fi
fi

exit 0
#echo -e "nvim\\nsecondo file" | dmenu -i -l 5 -p "Choose one: "
