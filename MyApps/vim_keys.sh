#!/bin/bash

# Define max length for keybindings
MAX_WIDTH=22

#Define windows size
WIDTH=640
HEIGHT=700
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
  printf "                              VIM SHORTCUTS\n"
  printf "\n"
  printf "GENERAL COMMANDS\n"
  format_line "z + z" ": Put the current line in the middle of the screen"
  format_line "f + char" ": To jump to the character specified"
  format_line "ctrl + o" ": Jump backward in the jump list"
  format_line "*" ": Search in the document the string under the cursor"
  format_line "g" ": Goto + comments menu"
  format_line ":%s/old/new/gc" ": Change old with new asking for confirm"
  printf "\n"
  printf "MACROS\n"
  format_line "q + reg-macro" ": Start recording macro"
  format_line "q" ": Stop recording macro"
  format_line "@ + reg-macro" ": Exec the macro"
  printf "\n"
  printf "BUFFERS\n"
  format_line "shift + h" ": Go to the previous buffer"
  format_line "shift + l" ": Go to the next buffer"
  format_line "space + b + o" ": Delete other buffers"
  printf "\n"
  printf "WINDOWS\n"
  format_line "space + w + s" ": Split window horizontally"
  format_line "space + w + v" ": Split window vertically"
  format_line "ctrl + (h,j,k,l)" ": Go to left, lower, upper, right window"
  format_line "ctrl + (arrows)" ": Change the size of the window"
  printf "\n"
  printf "TABS\n"
  format_line "space + tab + tab" ": New tab"
  format_line "space + tab + ([,])" ": Prev, next tab"
  format_line "space + tab + d" ": Close tab"
  format_line "space + tab + o" ": Close other tabs"
)

# Execute Rofi with the markup flag (and remove all column flags)
printf "%s" "$KEYBINDINGS" | rofi -dmenu \
  -u "0" \
  -a "2,9,14,19,25" \
  -sep '\n' \
  -config ~/dotfiles/.config/rofi_list/config.rasi \
  -theme-str 'window { width: '$WIDTH'; height: '$HEIGHT'; border: 3px; border-color: '$BORDER_COLOR'; }'
