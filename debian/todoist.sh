#!/bin/bash

sudo apt update
sudo apt install snapd
echo "reboot"
sudo snap install snapd

sudo snap install todoist
sudo snap set core experimental.refresh-app-awareness=true
