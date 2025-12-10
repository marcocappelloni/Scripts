#!/bin/bash

declare -a myArray=(

  "super + shift + h   ->    list of configs"
  "super + ctrl + h    ->    cheat sheets"
  "print               ->    screen shot"
  "ctrl + t            ->    fzf select"
  "ctrl + r            ->    fzf history"
  "alt + c             ->    fzf cd"
  "super + shift + t   ->    todo menu"
  "super + F9          ->    keybindings"
  "super + b           ->    vim keybindings"
  "super + e           ->    devel_environment"
)

chosen=$(printf '%s\n' "${myArray[@]}" | dmenu -l 15 -p "Keybindings:")
#chosen=$(printf '%s\n' "${myArray[@]}" | rofi -dmenu -p "Keybindings:" -theme-str 'window {width: 25%;}')
