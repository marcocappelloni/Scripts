#!/usr/bin/env bash

source times_arrays.sh

month_name_from_number() {
  # Use printf to format the number with a leading zero if needed
  month_number=$(printf "%02d" "$1")
  # Use the date command to get the full month name from the number
  month_name=$(date -d "2000-$month_number-01" +%B)
  echo "$month_name"
}

cron_jobs_for_month() {
  m=$1
  # Declare a local array to receive the passed hours
  local -a h=("${@:2}")
  result=""
  for j in $(seq 0 3); do
    time_string="${h[$j]}"

    # Split the string at the colon
    IFS=':' read -r hour minute <<<"$time_string"
    result+="$minute $hour 1-31 $m * $HOME/.local/bin/dimmer ${dimmer_parameters[$j]}"$'\n'
    # The $'\n' adds a proper newline for each cron job
  done

  echo "$result"
}

current_crontab=$(crontab -l | grep -v '\.local/bin/dimmer')
new_crontab="$current_crontab"$'\n'

for i in $(seq 1 12); do
  # The month number in cron jobs does not need a leading zero
  month_number_for_cron=$i

  # Read the times into an array
  read -ra hours <<<"${times_by_month[$(month_name_from_number $i)]}"

  # Pass the month number and the array correctly
  new_crontab+="$(cron_jobs_for_month "$month_number_for_cron" "${hours[@]}")"$'\n'
done

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
    $HOME/PersonalHome/Scripts/MyApps/dimmer/dimmer_time_check.sh &
  EOF
fi

