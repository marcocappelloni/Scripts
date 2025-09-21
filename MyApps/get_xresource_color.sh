#!/bin/bash

# Reads a color from the Xresources database.
# Usage: get_xresource_color <resource_name>
# Example: ./get_xresource_color "background"

# Check if an argument was provided
if [ -z "$1" ]; then
  exit 1
fi

RESOURCE_NAME="*$1"

# The command to get the color, with stripping
# xargs ensures that no leading/trailing whitespace messes up the output
# tr -d '\n' removes any trailing newline characters
xrdb -query | awk -v name="$RESOURCE_NAME:" '$1 == name {print $2}' | xargs | tr -d '\n'
