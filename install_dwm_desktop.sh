#|/bin/bash

sudo mkdir -p /usr/share/xsessions/

echo "[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic Window Manager
Exec=dwm
Type=XSession
Icon=dwm" | sudo tee /usr/share/xsessions/dwm.desktop
