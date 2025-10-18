#!/bin/bash

sudo apt install -y cups system-config-printer simple-scan
sudo apt install epson-inkjet-printer-escpr
sudo systemctl enable cups.service
