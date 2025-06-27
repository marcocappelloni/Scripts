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

# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--layout=reverse --border=bold --border=rounded --margin=3% --color=dark --color=border:#225577 --preview="bat --color=always {}"'

# Set the shell color
# PS1='\[\e[36m\]\u@\h:\w\$ \[\e[0m\]'
# Adding the git branch to the prompt
PS1='\[\e[34m\]\u@\h \[\e[32m\]\w \[\e[91m\]$(__git_ps1)\[\e[00m\]$ '

# Set up fzf key bindings and fuzzy completion
# CTRL-T Paste the selected files and directories onto the command-line
# CTRL-R Paste the selected command from history onto the command-line
# ALT-C cd into the selected directory
eval '$(fzf --bash)'

# Set the vi keybindings
# set -o 
EOF
