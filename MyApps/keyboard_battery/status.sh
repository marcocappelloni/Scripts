#!/bin/bash

device=$(upower -e | grep battery_hidpp | sed 's:.*/battery_::')
#echo "device: ${device}"
#echo "capacity $(cat /sys/class/power_supply/hidpp_battery_0/capacity_level)"
#cat /sys/class/power_supply/hidpp_battery_0/status

#upower -i /org//org/freedesktop/UPower/devices/battery_hidpp_battery_0
#device_name=$(echo "$device" | sed 's:.*/battery_::')
#echo "device_name: ${device_name}"
#cat /sys/class/power_supply/${device}/capacity_level
echo $(cat /sys/class/power_supply/${device}/status | cut -c 1-5)
