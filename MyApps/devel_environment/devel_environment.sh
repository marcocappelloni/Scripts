#!/bin/sh

KITTY_SESSION="/home/maky/PersonalHome/Scripts/MyApps/devel_environment/kitty_session.conf"
FILE1="/home/maky/PersonalHome/Documents/Ildiko/ShelfLocator/www/index.html"
FILE2="/home/maky/PersonalHome/Documents/Ildiko/ShelfLocator/www/js/app.js"
FILE3="/home/maky/PersonalHome/Documents/Ildiko/ShelfLocator/www/js/database.js"
FILE4="/home/maky/PersonalHome/Documents/Ildiko/ShelfLocator/www/js/search.js"

kitty --session $KITTY_SESSION &
kitty nvim $FILE1 $FILE2 $FILE3 $FILE4
# kitty --working-directory="$DIR1" &
# kitty --working-directory="$DIR1" &
# kitty nvim $FILE1 $FILE2
