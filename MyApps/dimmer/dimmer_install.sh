#!/bin/bash

# Save the current crontab entries to a variable
current_crontab=$(crontab -l)

# Append a new cron job to the variable
new_crontab="${current_crontab}
0 6 * * * ~/.local/bin/dimmer 1
0,30 17,18 * * * ~/.local/bin/dimmer 0.9
0,30 19 * * * ~/.local/bin/dimmer 0.8 night
0,30 20-23 * * * ~/.local/bin/dimmer 0.7 night
0,30 0-5 * * * ~/.local/bin/dimmer 0.7 night"

# Update the crontab with the new entries
echo "$new_crontab" | crontab -
