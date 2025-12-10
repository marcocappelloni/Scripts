#!/bin/bash

# --- KVM/QEMU Installation Script ---

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Virtual machines software installation"

# Check for virtualization support (Crucial step)
msg "Checking for CPU Virtualization Support..."
grep -E 'svm|vmx' /proc/cpuinfo &>/dev/null
if [ $? -ne 0 ]; then
  error "Hardware virtualization (VMX/SVM) is NOT detected."
  error "Please enable virtualization in your computer's BIOS/UEFI settings."
  exit 1
fi

# Install KVM, QEMU, and virt-manager
msg "Installing essential virtualization packages..."

exit 0
# - qemu-kvm: Core QEMU virtualization package with KVM support
# - libvirt-daemon-system: The system service (daemon) for managing virtualization
# - libvirt-clients: Command-line client tools for libvirt (e.g., 'virsh')
# - virt-manager: The graphical interface for managing VMs
# - bridge-utils: Utilities for configuring network bridging (useful for VMs)
# - cpu-checker: The utility used in Step 1 to check for VMX/SVM
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients virt-manager bridge-utils cpu-checker

# Check if the installation was successful
if [ $? -ne 0 ]; then
  error "Package installation failed. Exiting."
  exit 1
fi

# Configure libvirt daemon and services
# Enable and start the libvirt daemon
sudo systemctl enable --now libvirtd

# Add current user to 'libvirt' group
# This is necessary to manage VMs without using 'sudo'
sudo usermod -aG libvirt "$USER"

warning "You must log out and log back in (or reboot) for this change to take effect! ***"

# Verification
# Check if the 'virsh' command can list storage pools
msg "Checking libvirt connection..."
virsh list --all &>/dev/null
if [ $? -eq 0 ]; then
  msg "Verification successful (You are in the libvirt group)."
else
  error "Verification failed. Remember to LOG OUT and LOG BACK IN to activate group permissions."
fi

msg "Virtual machine software installed"
