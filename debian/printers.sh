#!/bin/bash

sudo apt install -y cups system-config-printer simple-scan
sudo systemctl enable cups.service

echo "Download the driver and install it"
