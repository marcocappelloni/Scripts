#!/bin/bash

original_script="/usr/bin/dmenu_run"
new_line="export PATH=$PATH:/var/lib/flatpak/exports/bin:~/.local/share/flatpak/exports/bin"

# Temporary file to store the modified content
temp_file=$(mktemp)

head -n 1 "$original_script" > "$temp_file"
echo -e "\n$new_line\n" >> "$temp_file"
tail -n +2 "$original_script" >> "$temp_file"

sudo mv "$temp_file" "$original_script"
