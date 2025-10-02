#!/bin/bash

source "/home/maky/PersonalHome/Scripts/MyApps/git_status/check_git_status.sh"
source "/home/maky/PersonalHome/Scripts/MyApps/git_status/git_directories.sh"
source "/home/maky/PersonalHome/Scripts/MyApps/git_status/bash_colors.sh"

declare -a modified_repo

for directory in "${directories[@]}"; do
  if $(check_status "$directory"); then
    modified_repo+=("$directory")
  fi
done

if [ ${#modified_repo[@]} -eq 0 ]; then
  #notify-send "Git repos" "All the git repositories are up to date"
  zenity --info --text="All the git repositories are up to date"
  exit 0
fi

selected_repo=$(printf '%s\n' "${modified_repo[@]}" | dmenu -i -l 15 -p "Modified git repos")

# Check if the user made a selection (i.e., didn't press Esc or close dmenu)
if [ -z "$selected_repo" ]; then
  exit 0 # Exit quietly if no selection was made
fi

FULL_PATH="$HOME/$selected_repo"

# Execute the command to open the terminal
if [ -d "$FULL_PATH" ]; then
  # Open the new terminal instance
  exec kitty --working-directory "$FULL_PATH" &
else
  # Notify the user if the final path is not a valid directory
  notify-send "Terminal Error" "Directory not found: $FULL_PATH"
fi
