#!/usr/bin/env bash

#sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
sudo apt update && sudo apt install -y qemu-system-x86 libvirt-daemon-system libvirt-clients bridge-utils
sudo usermod -aG kvm $USER
