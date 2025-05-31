#!/bin/bash

# Bash script to install the app images

# Directories used
PACKAGES_DIR=$HOME/packages
EXEC_DIR=$HOME/.local/bin

# Create the Directories if they don't exist
mkdir -p $PACKAGES_DIR
mkdir -p $EXEC_DIR

# List of app to install. Each element is the name of the executable that will break
# added to the executable Directory
APP_LIST=(
  "nvim"
  "texstudio"
)

echo "Do you want to install the following app images? (Y/N)"
echo "${APP_LIST[@]}"
read answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
  exit 0
fi

for app in "${APP_LIST[$@]}"; do
  echo "Insert the link to the appimage file for $app:"
  read link

  # download the app image in the current directory
  curl -LO $link

  # extract the file name from the link
  filename=${link##*/} # This removes everything up to and including the last slash

  # give executable permit
  chmod u+x $filename

  # move the file downloaded to the packages directory
  mv $filename $PACKAGES_DIR

  # create a symbolic link to the file downloaded into the executable directory
  ln -s "$HOME/packages/$filename" "$EXEC_DIR/$app"

done

echo "Reboot to enable the changes"
