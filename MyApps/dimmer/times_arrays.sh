#!/usr/bin/env bash

declare -A times_by_month

times_by_month=(
  [January]="08:00 14:30 15:30 16:30"
  [February]="07:15 15:15 16:15 17:15"
  [March]="06:15 16:00 17:00 18:00"
  [April]="06:00 18:00 19:00 20:00"
  [May]="05:15 18:45 19:45 20:45"
  [June]="04:45 19:15 20:15 21:15"
  [July]="05:00 19:00 20:00 21:00"
  [August]="05:45 18:15 19:15 20:15"
  [September]="06:30 17:15 18:15 19:15"
  [October]="07:15 15:30 16:30 17:30"
  [November]="07:30 14:15 15:15 16:15"
  [December]="08:00 14:00 15:00 16:00"
)

declare -a dimmer_parameters

dimmer_parameters=(
  "1"
  "0.9"
  "0.8 night"
  "0.7 night"
)
