#!/bin/bash

sudo apt install lsd
cp .bash_aliases $HOME/

##### MY OPTIONS AND ALIASES ADDED #####
cat <<EOF >>$HOME/.bashrc

# ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ALIASES ###
source $HOME/.bash_aliases

### EXPORT ###
export EDITOR='nvim'
export VISUAL='nvim'

# Shell options "shopt"
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # includes filenames beginning with a '.' in the results of filename expansion. 
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases

# Set the vi keybindings
# set -o 
EOF
