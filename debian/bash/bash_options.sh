#!/bin/bash

# Script to setup the bash shell options

source $HOME/PersonalHome/Scripts/debian/setup/DIR_SETUP_SCRIPTS/utilities.sh

mkdir -p $BACKUP_DOTFILES_DIR

msg "Setting up the bash shell..."
install_single_app "lsd"
# cp .bash_aliases $HOME/

msg "Backing up the original .bashrc files inside the home directory"
cp $HOME/.bashrc $BACKUP_DOTFILES_DIR/.bashrc
mv $HOME/dotfiles/.bashrc $HOME/dotfiles/.bashrc_bck

##### MY OPTIONS AND ALIASES ADDED #####
cat <<'EOF' >>"$HOME/.bashrc"

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
shopt -s expand_aliases # expand aliases

# FZF
show_file_or_dir_preview="if [ -d {} ]; then tree -L 2 {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Open in tmux popup if on tmux, otherwise use --height mode

export FZF_DEFAULT_OPTS='--exact --layout=reverse --border=bold --border=rounded --margin=3% --color=dark --color=border:#943B2F --preview="bat --color=always {}"'

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_CTRL_R_OPTS="--style minimal --no-sort --no-preview --info inline"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo \${}'" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  git) fzf --preview 'git show --color=always {-1}' "$@" ;;
  *) fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Set up fzf key bindings and fuzzy completion
# CTRL-T Paste the selected files and directories onto the command-line
# CTRL-R Paste the selected command from history onto the command-line
# ALT-C cd into the selected directory
eval '$(fzf --bash)'

if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

# Set the vi keybindings
# set -o 

EOF

msg "Bash shell set up"
