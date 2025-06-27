#!/bin/bash

cdor() {
  [[ $# -eq 0 ]] && return
  builtin cd "$@"
}

bettercd() {
  cdor $1
  if [ -z $1 ]; then
    selection="$(ls -ad */ | fzf --height 45% --reverse --info hidden --prompt "$(pwd)/" --preview ' cd_pre="$(echo $(pwd)/$(echo {}))";
                    echo $cd_pre;
                    echo;
                    ls -a --color=always "${cd_pre}";
                    termpix --width 100 --true-color {} 2>/dev/null;
                    bat --style=numbers --theme=ansi --color=always {} 2>/dev/null' --bind alt-j:preview-down,alt-k:preview-up --preview-window=right:45%)"
    if [[ -d "$selection" ]]; then
      >/dev/null cdor "$selection"
    fi
  fi
}

# ARCHIVE EXTRACTIONS
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
      case $1 in
      *.tar.bz2) tar xvjf $1 ;;
      *.tar.gz) tar xvzf $1 ;;
      *.tar.xz) tar xvJf $1 ;;
      *.lzma) unlzma $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar x -ad $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvjf $1 ;;
      *.tgz) tar xvzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *.xz) unxz $1 ;;
      *.exe) cabextract $1 ;;
      *) echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
alias extr='extract '
function extract_and_remove {
  extract $1
  rm -f $1
}
alias extrr='extract_and_remove '

# List of aliases for the bash shell ###

alias cdb='bettercd'

#list
alias ls='lsd --color=auto'
alias la='lsd -A'
alias ll='lsd -Alh'
alias l.="lsd -A | grep -E '^\.'"
alias dir='lsd -al'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'

#readable output
alias df='df -h'

#free
alias free="free -mth"

# Aliases for software managment
alias update='sudo apt update && sudo apt upgrade'

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

alias mv="mv -i"
#alias rm="rm -I"
alias rm="trash-put -v"

### GIT
alias push="git push -u origin main"

### QTILE
alias qtconf="cd ~/.config/qtile"
alias qtlog="nvim ~/.local/share/qtile/qtile.log"

### DWM
alias dwmconf="nvim ~/packages/suckless/dwm/config.def.h"
alias dwmmake="cd ~/packages/suckless/dwm; rm config.h; sudo make install; cd -"
alias dwmgo="cd ~/packages/suckless/dwm/"

### NEOVIM
alias nvconf="cd ~/.config/nvim"

### HELIX
alias hx="helix"

#alias trash-clean="rm -rf ~/.local/share/Trash/*"

#our experimental - best option for the moment
alias rams='rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'
