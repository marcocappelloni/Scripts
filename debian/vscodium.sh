#!/usr/bin/env bash

# website: https://vscodium.com/

# Add the GPG key of the repository
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg |
  gpg --dearmor |
  sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

# Add the repository
echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' |
  sudo tee /etc/apt/sources.list.d/vscodium.sources

# Update and install vscodium
sudo apt update && sudo apt install codium
