#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt install pulseaudio pulseaudio-utils alsa-utils pavucontrol volumeicon
echo "configure volumeicon adding pulseaudio with the preference menu"
