#!/bin/sh

delay=300
rate=40

#Increase key speed via a rate change
xset r rate $delay $rate

# Set for the other sessions
echo "xset r rate $delay $rate" >> ~/.xinitrc
