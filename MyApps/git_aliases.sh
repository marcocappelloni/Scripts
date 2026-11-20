#!/bin/bash

# Define max length for keybindings
MAX_WIDTH=22

#Define windows size
WIDTH=800
HEIGHT=520
BORDER_COLOR=$(get_xresource_color color6)

# Function to pad and format a line
format_line() {
  local key="$1"
  local desc="$2"

  # Calculate padding needed
  local pad_len=$((MAX_WIDTH - ${#key}))
  if [ "$pad_len" -lt 1 ]; then
    pad_len=1
  fi
  local padding=""

  # Create padding using spaces
  for i in $(seq 1 $pad_len); do padding="${padding} "; done

  printf "%s%s%s\n" "$key" "$padding" "$desc"
}

KEYBINDINGS=$(
  printf "                              GIT ALIASES\n"
  printf "\n"
  printf "Status & Navigation\n"
  format_line "git st" ": git status -s. Shows only changed files."
  format_line "git co" ": checkout. Branch switch (git co main)"
  format_line "git cob" ": checkout -b. Create and checkout to a new branch (git cob newbranch)"
  printf "\n"
  printf "Commit & Staging\n"
  format_line "git cm" ": commit -m. Single line commit message"
  format_line "git unstage" ": reset HEAD --. Removes files from staging withoud discarding changes"
  format_line "push" ": git push -u origin main."
  printf "\n"
  printf "Stash Management\n"
  format_line "git save" ": stash push -m. Stash with a custom description"
  format_line "git pop" ": stash pop. Restore the most recently stashed changes"
  printf "\n"
  printf "Visual History\n"
  format_line "git lg" ": log --online --graph --decorate --all. History tree"
  printf "\n"
  printf "Other\n"
  format_line "g" ": lazygit. GUI for git commands"
)

# Execute Rofi with the markup flag (and remove all column flags)
printf "%s" "$KEYBINDINGS" | rofi -dmenu \
  -u "0" \
  -a "2,7,12,16,19" \
  -sep '\n' \
  -config ~/dotfiles/rofi_list/.config/rofi_list/config.rasi \
  -theme-str 'window { width: '$WIDTH'; height: '$HEIGHT'; border: 3px; border-color: '$BORDER_COLOR'; }' #  -a "2,9,14,19,25" \
