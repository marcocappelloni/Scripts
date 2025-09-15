# Installation

To enable the dimmer in a PC follow this instructions:

1) Exec the file dimmer_install.sh
4) If you have already the call for the file dimmer_time_check.sh in the autostart file of you WM than answer no to the question asked otherwise answer "y" if you have dwm or put the call in your autostart section

# Scripts functionalities
## dimmer.sh 
Actual script to set the brightness of the monitor
## dimmer_install.sh
Script to insert the cron jobs in the crontab and add the call to the time check script to the autostart file of dwm
## dimmer_time_check.sh
Script called at the start of the system to check the actual time and set the right dimm straight away
## times_arrays.sh
This script contains the tables with all the times for the all year and the one with the parameters to pass to the dimmer.sh script
