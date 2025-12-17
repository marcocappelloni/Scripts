#!/bin/bash

# This script will install the driver for the epson XP-245

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/../utilities.sh

msg "Installing driver for the printer..."
sudo apt install printer-driver-escpr -y
warning "If this driver doesn't work you have to download it from the Epson website"

msg "To install the epson printer utility follows this steps:"
msg "1) Go to this website:"
msg "https://download-center.epson.com/softwares/?device_id=XP-243+245+247+Series&region=GB&os=DEBX64&language=en"
msg "and download the utility to the Download directory."
msg "2) In another terminal window go to the Download directory"
msg "3) Exec the following command:"
msg "sudo dpkg -i [filename.deb]"
question "Press Enter when done"
read button
