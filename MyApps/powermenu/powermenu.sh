#!/usr/bin/env bash

# CMDs
host=$(hostname)
#style="$HOME/.config/powermenu/style.rasi"
style="$HOME/PersonalHome/Scripts/MyApps/powermenu/style.rasi"

# Options
shutdown='Shutdown'
reboot='Reboot'
logout='Logout'
yes='Yes'
no='No'

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "$host" \
    -theme ${style}
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme ${style}
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$shutdown\n$logout\n$reboot" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      systemctl reboot
    elif [[ $1 == '--logout' ]]; then
      desktop=$(echo $DESKTOP_SESSION)
      echo "You are on "$desktop
      case $desktop in
      dk)
        dkcmd exit
        ;;
      hyprland)
        hyprctl dispatch exit
        ;;
      herbstluftwm)
        herbstclient quit
        ;;
      *)
        pkill $desktop
        #loginctl kill-user $USER
        ;;
      esac
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$logout)
  run_cmd --logout
  ;;
esac
