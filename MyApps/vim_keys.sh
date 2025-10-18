#!/bin/bash

# Define max length for keybindings
MAX_WIDTH=22

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
  printf "GENERAL COMMANDS\n"
  format_line "z + z" ": Put the current line in the middle of the screen"
  format_line "f + char" ": To jump to the character specified"
  format_line "ctrl + o" ": Jump backward in the jump list"
  format_line "*" ": Search in the document the string under the cursor"
  format_line "g" ": Goto + comments menu"
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
  -a "0,7,12,17,23" \
  -sep '\n' \
  -config ~/dotfiles/.config/rofi_list/config.rasi

# # Ensure LIST_ITEMS still uses the tab character (\t)
# LIST_ITEMS=$(printf "GENERAL COMMANDS\nctrl + l\t: explanation for the keybinding\nshift + ctrl + l\t: explanation for this other keybinding\nanother option\t: another explanation\nANOTHER STYLED HEADER\n")
#
# # Use the -display-column-separator flag
# printf "%s" "$LIST_ITEMS" | rofi -dmenu \
#   -a "0,4" \
#   -sep '\n' \
#   -display-column-separator '\t' \
#   -config ~/dotfiles/.config/rofi_list/config.rasi
# # Define all elements, separated by newline
# LIST_ITEMS=$(printf "GENERAL COMMANDS\nOption 1\nOption 2\nAnother Styled Item")
#
# # Define the indexes you want to style (0 and 3)
# # You can use -a for all of them, or split them into -a and -u for two different styles
# STYLED_INDICES="0,3"
#
# # Execute Rofi
# printf "%s" "$KEYBINDINGS" | rofi -dmenu \
#   -a "$STYLED_INDICES" \
#   -config ~/dotfiles/.config/rofi_list/config.rasi

#zenity --info --width=450 --text="$KEYBINDINGS" --title="Vim keybindings"
#echo "<span color=\"$col\"><b><u>GENERAL COMMANDS</u></b></span>" | rofi -dmenu -markup -config ~/dotfiles/.config/rofi_list/config.rasi
