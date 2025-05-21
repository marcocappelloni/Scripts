#!/bin/bash

### Sctipts to create all the simlinks for my apps to execute them from everywhere
### the only one that will have to be treated differently is "wake-up-screen" where
### it needs to be put a run command into the autostart file of the window manager.

# Define directories
DIR_SCRIPT="~/PersonalHome/Scripts/MyApps"
DIR_EXEC="~/.local/bin"

# Create exec directory if is missing
mkdir -p "$DIR_EXEC"

# Backup
ln -s $DIR_SCRIPT/Backup/BckScript.sh $DIR_EXEC/backup

# Clock rofi
ln -s $DIR_SCRIPT/clock_rofi/clock.sh $DIR_EXEC/clock

# Monitors night dimmer
ln -s $DIR_SCRIPT/dimmer/dimmer.sh $DIR_EXEC/dimmer

# Dmenu to open the config files
ln -s $DIR_SCRIPT/list_config_dmenu.sh $DIR_EXEC/listconfig

# Passmenu
ln -s $DIR_SCRIPT/passmenuscript/passmenu $DIR_EXEC/passmenu

# Powermenu
ln -s $DIR_SCRIPT/powermenu/powermenu.sh $DIR_EXEC/powermenu
