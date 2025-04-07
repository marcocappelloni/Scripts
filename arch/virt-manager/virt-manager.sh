#!/bin/bash

##### Script to install Virtual Manager, an alternative to Virtual Box to create virtual machines #####


echo "Checking if the system has all the virtualizations enabled in the firmware..."
LC_ALL=C lscpu | grep Virtualization

echo "The result is AMD-V or VT-x ?(Y/N)" 
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	echo "Try to check if the virtualization is enabled in your BIOS"
    exit 1
fi

echo "Checking if the necessary modules are available in the kernel..."
zgrep CONFIG_KVM= /proc/config.gz

echo "The result is y or m?(Y/N)" 
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	echo "Try to check your BIOS"
    exit 1
fi

echo "Checking that the kernel modules are automatically loaded..."
lsmod | grep kvm

echo "The result is empty?(Y/N)" 
read answer

if [[ ($answer = "Y") || ($answer = "y") ]]
then
	echo "Try to check your BIOS"
    exit 1
fi

echo "Installing QEMU..."
sudo pacman -S qemu-full libvirt virt-manager ebtables edk2-ovmf dnsmasq libosinfo tuned

echo "Enabling libvirtd..."
sudo systemctl enable libvirtd
echo "Starting libvirtd..."
sudo systemctl start libvirtd
echo "Checking the status of libvirtd..."
sudo systemctl status libvirtd
echo "Adding my user to the group libvirtd..."
sudo usermod -G libvirt -a $USER

echo "Checking if you have a network defined..."
sudo virsh net-list --all
echo "Is the default network present in the list above?(Y/N)"
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	echo "Creating the default network..."
    sudo virsh net-define --file virt-man-default.xml
    sudo virsh net-list --all
fi

echo "Is the default network already active?(Y/N)"
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	echo "Starting the default network..."
    sudo virsh net-start default
fi

echo "Is the autostart value equal to yes?(Y/N)"
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
	echo "Setting the autostart..."
    sudo virsh net-autostart --network default
fi
