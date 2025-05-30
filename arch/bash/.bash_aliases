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

# List of aliases for the bash shell ###

alias cdb='bettercd'

#list
#alias ls='ls --color=auto'
#alias la='ls -A'
#alias ll='ls -AlFh'
#alias l.="ls -A | grep -E '^\.'"
#alias dir='ls -al'
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
alias update='sudo pacman -Syyu'

# paru as aur helper - updates everything
alias upall="paru -Syu --noconfirm"

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="reboot"

alias mv="mv -i"
alias rm="rm -I"

alias push="git push -u origin main"

alias qtconf="cd ~/.config/qtile"
alias qtlog="nvim ~/.local/share/qtile/qtile.log"
alias nvconf="cd ~/.config/nvim"

alias hx="helix"

alias trash-clean="rm -rf ~/.local/share/Trash/*"

#our experimental - best option for the moment
alias rams='rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'
