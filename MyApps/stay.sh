#!/bin/bash

# Script to launch a shell command in a new kitty window and waiting
# for the enter before closing the new window

kitty -e bash -c "$*; echo -e; tput setaf 4 bold; read -p 'Press enter to continue.' -s"
