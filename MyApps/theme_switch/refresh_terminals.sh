#!/usr/bin/env bash

# 1. Pull colors from Xresources (which you just updated with dmenu)
bg=$(get_xresource_color background)
fg=$(get_xresource_color foreground)

# --- KITTY UPDATE ---
# This updates all active Kitty windows instantly
if pgrep -x kitty >/dev/null; then
  kitty @ set-colors -a "background=$bg" "foreground=$fg" >/dev/null 2>&1 || true
  # Update the first 16 colors
  for i in {0..15}; do
    col=$(get_xresource_color "color$i")
    kitty @ set-colors -a "color$i=$col" >/dev/null 2>&1 || true
  done
fi

# --- GHOSTTY / GENERAL UPDATE ---
# Ghostty handles the standard escapes if sent to its TTY
update_ghostty() {
  local tty=$1
  # Standard OSC sequences for BG and FG
  echo -ne "\033]10;${fg}\007" >"$tty"
  echo -ne "\033]11;${bg}\007" >"$tty"
}

for pts in /dev/pts/[0-9]*; do
  update_ghostty "$pts" 2>/dev/null
done
