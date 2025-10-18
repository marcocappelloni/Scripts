#!/bin/bash

# This script install the desktop "capacities" app appImage

PACKAGES_DIRECTORY="/home/maky/packages"
# https://capacities-desktop-app.fra1.cdn.digitaloceanspaces.com/Capacities-1.53.24.AppImage
echo "Insert the link of the Capacities desktop app appimage from the website: "
read LINK

curl --output-dir $PACKAGES_DIRECTORY -o capacities.AppImage $LINK
if [[ $? -ne 0 ]]; then
  echo "Could not download the file. Check the address"
  exit 1
fi

# Make the AppImage executable
chmod u+x $PACKAGES_DIRECTORY/capacities.AppImage
# Extract the contents
$PACKAGES_DIRECTORY/capacities.AppImage --appimage-extract
# Move the extracted files to a permanent location (e.g., /opt)
sudo mv squashfs-root $PACKAGES_DIRECTORY/capacities
# Fix the ownership and permissions of the sandbox file
sudo chown root:root $PACKAGES_DIRECTORY/capacities/chrome-sandbox
sudo chmod 4755 $PACKAGES_DIRECTORY/capacities/chrome-sandbox

# Make the executable reachable from everywhere
ln -s $PACKAGES_DIRECTORY/capacities/AppRun $HOME/.local/bin/capacities

# Add the desktop entry in the right place
cp capacities.desktop /home/maky/.local/share/applications/
cp capacities-dark.webp $PACKAGES_DIRECTORY/
