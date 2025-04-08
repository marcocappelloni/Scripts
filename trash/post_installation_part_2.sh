blocks_default_config=/etc/i3blocks.conf
blocks_default_modules_dir=/usr/share/i3blocks
blocks_base_dir=$HOME/.config/i3blocks
blocks_config=$blocks_base_dir/config
blocks_modules_dir=$blocks_base_dir/modules

mkdir $blocks_base_dir
mkdir $blocks_modules_dir
touch $blocks_config

##### COPY I3BLOCKS MODULES AND CHANGE OWNERSHIP #####
cp $blocks_default_modules_dir/volume $blocks_modules_dir
sudo chown $USER:$USER $blocks_modules_dir/volume
cp $blocks_default_modules_dir/wifi $blocks_modules_dir/
sudo chown $USER:$USER $blocks_modules_dir/wifi


##### WRITE THE CONFIG FILE FOR I3BLOCKS #####
cp $blocks_default_config $blocks_config
#sed -i 's/# command=\/usr.*/command=/' /path/to/file
sed -i 's%command=/usr.*%command=~/.config/i3blocks/modules/$BLOCK_NAME%' $blocks_config


echo "Comment the block of lines regarding the wifi. Press enter to continue"
read answer

sudo nano /etc/network/interfaces

echo "To make this changes effectives you need to reboot the computer. Reboot now? (Y/N)"
read answer

if [[ ($answer="Y") || ($answer="y") ]]
then
	sudo reboot
fi

