#!/usr/bin/env bash

###### START ######
# Steps to ensure that when we close the lid of the laptop the system will not go on sleep mode
sudo nano /etc/systemd/logind.conf
# Uncomment this lines and set like this:
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
# Restart the service
sudo systemctl restart systemd-logind
###### END ######

###### START ######
# With this command we can check the actual ip address assigned
######
ip addr show
###### END ######

###### START ######
# Command to connect to the server
######
ssh maky@192.168.x.x
###### END ######

###### START ######
# Steps to ensure that the wifi stays on and doesn't go in power save mode
######
# Check power management status
iw dev interface_name get power_save

# Switch off if is on
sudo iw dev interface_name set power_save off

# To make it permanent create this file
sudo nano /etc/network/if-up.d/wifi-powersave-off
# Copy on this file the following 2 lines
- #!/bin/sh
- /usr/sbin/iw dev wlp1s0 set power_save off
# Make it executable
sudo chmod +x /etc/network/if-up.d/wifi-powersave-off
###### END ######

###### START ######
# Steps to install docker
######
# Install the necessary Helper tools
sudo apt update && sudo apt install -y ca-certificates curl gnupg
# Add the Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
# Install the Docker engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Add the user to the Docker group
sudo usermod -aG docker $USER
###### END ######
