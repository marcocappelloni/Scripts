#!/bin/bash

# Save the current crontab entries to a variable
current_crontab=$(crontab -l)

# Append a new cron job to the variable
new_crontab="${current_crontab}
0 6 * * * $HOME/.local/bin/dimmer 1
0 17 * * * $HOME/.local/bin/dimmer 0.9
0 19 * * * $HOME/.local/bin/dimmer 0.8 night
0 20 * * * $HOME/.local/bin/dimmer 0.7 night"

# Update the crontab with the new entries
echo "$new_crontab" | crontab -

# Insert the call of the dimmer check in the autostart file of dwm
echo "Do you want to insert the call of the dimmer check in the autostart file of dwm? (Y/N)"
read answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
  echo "Bye"
  exit 0
fi

autostartfile="$HOME/.dwm/autostart.sh"
if ! grep -q "dimmer_time_check.sh" $autostartfile; then
  cat << EOF >> $autostartfile
    $HOME/PersonalHome/Scripts/MyApps/dimmer/dimmer_time_check.sh
  EOF
fi

