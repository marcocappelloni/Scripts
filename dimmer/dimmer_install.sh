#!/bin/bash

# Save the current crontab entries to a variable
current_crontab=$(crontab -l)

# Append a new cron job to the variable
new_crontab="${current_crontab}
0 6 * * * /home/maky/PersonalHome/Scripts/dimmer.sh 1
0,30 17,18 * * * /home/maky/PersonalHome/Scripts/dimmer.sh 0.9
0,30 19 * * * /home/maky/PersonalHome/Scripts/dimmer.sh 0.8 night
0,30 20-23 * * * /home/maky/PersonalHome/Scripts/dimmer.sh 0.7 night
0,30 0-5 * * * /home/maky/PersonalHome/Scripts/dimmer.sh 0.7 night"

# Update the crontab with the new entries
echo "$new_crontab" | crontab -
