#!/bin/bash

# Script to change the themes for DWM, DMENU and SLSTATUS
# The source codes will be recompiled, it means that at the end we need to logout
# from DWM to see the result

echo "Which theme do you want to install?"
read -p "default/nimona:  " answer
THEME=$answer

PATH_DWM="$HOME/packages/suckless/dwm"
PATH_DMENU="$HOME/packages/suckless/dmenu"
PATH_SLSTATUS="$HOME/packages/suckless/slstatus"

INCLUDE_PATTERN="#include \"themes/"

search_and_replace() {

  PATH_FILE=$1
  SEARCH_PATTERN=$2
  NEW_LINE=$3

  echo "path $PATH_FILE"
  echo "pattern $SEARCH_PATTERN"
  echo "new $NEW_LINE"

  echo "Searching for pattern in $PATH_FILE..."

  # Use grep to find lines matching the pattern
  if grep -qF "$SEARCH_PATTERN" "$PATH_FILE"; then
    echo "Pattern found!"
    # Replace the *first* line that contains the SEARCH_PATTERN
    OLD_LINE_TO_REPLACE=$(grep -m 1 -F "$SEARCH_PATTERN" "$PATH_FILE")

    if [ -z "$OLD_LINE_TO_REPLACE" ]; then
      echo "Error: Could not retrieve the exact line to replace using the search pattern."
      exit 1
    fi

    echo "Found line to replace: \"$OLD_LINE_TO_REPLACE\""
    echo "Replacing with: \"$NEW_LINE\""

    # Use sed to replace the found line with the new line
    # We use a non-default delimiter '|' to avoid issues with '/' in file paths or includes.
    # We also escape forward slashes in the OLD_LINE_TO_REPLACE and NEW_LINE variables
    # to prevent them from being interpreted as sed delimiters within the "s///" command.
    # This makes the script more robust to arbitrary line content.
    ESCAPED_OLD_LINE=$(printf '%s\n' "$OLD_LINE_TO_REPLACE" | sed 's/[&/\]/\\&/g')
    ESCAPED_NEW_LINE=$(printf '%s\n' "$NEW_LINE" | sed 's/[&/\]/\\&/g')

    sed -i "s|${ESCAPED_OLD_LINE}|${ESCAPED_NEW_LINE}|g" "$PATH_FILE"

    if [ $? -eq 0 ]; then
      echo "Successfully replaced line in $PATH_FILE"
    else
      echo "Error: Failed to replace line in $PATH_FILE"
      exit 1
    fi
  else
    echo "Pattern not found in $PATH_FILE. No substitution performed."
    exit 0

  fi
}

recompile() {
  ACTUAL_PATH=$1

  cd $ACTUAL_PATH
  rm "./config.h"
  sudo make install
}

search_and_replace "$PATH_DWM/config.def.h" "$INCLUDE_PATTERN" "#include \"themes/${THEME}.h\""
search_and_replace "$PATH_DMENU/config.def.h" "$INCLUDE_PATTERN" "#include \"themes/${THEME}.h\""
search_and_replace "$PATH_SLSTATUS/config.def.h" "$INCLUDE_PATTERN" "#include \"themes/${THEME}.h\""

recompile $PATH_DWM
recompile $PATH_DMENU
recompile $PATH_SLSTATUS

FEH_PATTERN="feh --bg-fill"
FEH_FILE="$HOME/.dwm/autostart.sh"

case "$THEME" in
"default")
  WALLPAPER_1=/home/maky/Pictures/wallpapers/nordic-wallpapers/ign_batman.png
  WALLPAPER_2=/home/maky/Pictures/wallpapers/nordic-wallpapers/ign_groot.png
  ;;
"nimona")
  WALLPAPER_1=/home/maky/Pictures/wallpapers/ign_iceAndFire.jpg
  WALLPAPER_2=/home/maky/Pictures/wallpapers/ign_tokyo.jpg
  ;;
*)
  WALLPAPER_1=/home/maky/Pictures/wallpapers/nordic-wallpapers/ign_batman.png
  WALLPAPER_2=/home/maky/Pictures/wallpapers/nordic-wallpapers/ign_groot.png
  ;;
esac

search_and_replace "$FEH_FILE" "$FEH_PATTERN" "feh --bg-fill  $WALLPAPER_1 $WALLPAPER_2 &"
feh --bg-fill $WALLPAPER_1 $WALLPAPER_2 &
