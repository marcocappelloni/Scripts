#!/bin/sh

#Script to download and install the passmenu script

DIR_SCRIPT="$HOME/PersonalHome/Scripts/passmenuscript"
DIR_EXEC="$HOME/.local/bin"

mkdir -p "$DIR_SCRIPT"

curl -o $DIR_SCRIPT/passmenu.sh https://git.zx2c4.com/password-store/plain/contrib/dmenu/passmenu
curl -o $DIR_SCRIPT/README.md https://git.zx2c4.com/password-store/plain/contrib/dmenu/README.md

chmod u+x $DIR_SCRIPT/passmenu.sh

ln -s "$DIR_SCRIPT/passmenu.sh" "$DIR_EXEC/passmenu"

exit 0
