#!/bin/bash

# install packages to access the drive connected via usb on the router
sudo apt update
sudo apt install smbclient cifs-utils
echo "To open it use a file manager and type smb://192.168.1.1"
