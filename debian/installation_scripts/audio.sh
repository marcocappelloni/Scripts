#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt install amixer pulseaudio pulseaudio-utils alsa-utils pavucontrol pamixer volumeicon
echo "configure volumeicon adding pulseaudio with the preference menu"
