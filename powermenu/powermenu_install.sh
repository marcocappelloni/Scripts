#!/bin/bash

##### Copy configuration files in .config #####
config_dir="$HOME/.config/powermenu"

echo "Creating configuration directory..."
mkdir -p $config_dir

echo "Copying configuration files in the config directory..."
cp -r ./colors $config_dir
cp ./powermenu.sh $config_dir
cp ./style.rasi $config_dir

# Create script in /usr/loca/bin
echo "Copying the actual command that will be executed in /usr/local/bin..."
sudo ln -s $config_dir/powermenu.sh /usr/local/bin/powermenu
# sudo cp ./powermenu /usr/local/bin

# echo "Changing the permissions of the powermenu command..."
# sudo chmod +rx /usr/local/bin/powermenu

echo "TO USE IT ADD THE KEYBINDING TO EXECUTE THE COMMAND \"powermenu\" "
