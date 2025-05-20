#!/bin/bash

#####  Script to install Redshift, a small app to enable the night warm light of the monitor  #####

echo "Installing redshift..."
sudo apt install redshift
echo "Copying configuration file..."
cp redshift.conf ~/.config
echo "File di configurazione copiato"
echo "Per usare redshift o avviarlo manualmente oppure inserirlo fra gli autostart"
