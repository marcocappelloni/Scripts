#!/usr/bin/env bash

# install prerequisite softwares
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

echo "MANUAL STEPS"
echo "1 - Install VS Code"
echo "2 - Install Flutter (Dart Code) extension on VS Code"
echo "3 - Add flutter bin path to the .profile file"
echo "4 - Add the instruction 'export CHROME_EXECUTABLE=/snap/bin/brave' to the .profile file"

# install required system packages
sudo apt update && sudo apt install -y openjdk-17-jdk clang cmake ninja-build pkg-config mesa-utils

sudo apt install libgtk-3-dev

# accept android licenses
flutter doctor --android-licenses

flutter doctor
