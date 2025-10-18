#!/bin/bash

### Sctipts to create all the simlinks for my apps to execute them from everywhere
### the only one that will have to be treated differently is "wake-up-screen" where
### it needs to be put a run command into the autostart file of the window manager.

# Define directories
DIR_SCRIPT="$HOME/PersonalHome/Scripts/MyApps"
DIR_EXEC="$HOME/.local/bin"

# Create exec directory if is missing
mkdir -p "$DIR_EXEC"

# Backup
ln -s "$DIR_SCRIPT/Backup/BckScript.sh" "$DIR_EXEC/backup"

# Clock rofi
ln -s "$DIR_SCRIPT/clock_rofi/clock.sh" "$DIR_EXEC/clock"

# Monitors night dimmer
ln -s "$DIR_SCRIPT/dimmer/dimmer.sh" "$DIR_EXEC/dimmer"

# Dmenu to open the config files
ln -s "$DIR_SCRIPT/list_config_dmenu.sh" "$DIR_EXEC/listconfigs"

# Passmenu
# ln -s "$HOME/PersonalHome/Scripts/passmenuscript/passmenu.sh" "$DIR_EXEC/passmenu"

# Powermenu
ln -s "$DIR_SCRIPT/powermenu/powermenu.sh" "$DIR_EXEC/powermenu"

# Cheat Sheet
ln -s "$DIR_SCRIPT/cheat_sheet.sh" "$DIR_EXEC/ch_sh"

# Stay
ln -s "$DIR_SCRIPT/stay.sh" "$DIR_EXEC/stay"

# Todo
ln -s "$DIR_SCRIPT/todo.sh" "$DIR_EXEC/todo"

# Todo menu
ln -s "$DIR_SCRIPT/todomenu.sh" "$DIR_EXEC/todomenu"

# Keybindings list
ln -s "$DIR_SCRIPT/Keybindings_list.sh" "$DIR_EXEC/keybindings"

# Git global status check
ln -s "$DIR_SCRIPT/git_global_status.sh" "$DIR_EXEC/gitgstatus"

# Keyboard battery status
ln -s "$DIR_SCRIPT/keyboard_battery/status.sh" "$DIR_EXEC/kb_status"
