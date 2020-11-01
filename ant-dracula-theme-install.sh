#!/bin/sh

if [ ! -f "dracula-gtk-theme.zip" ]; then
  wget https://github.com/dracula/gtk/archive/master.zip -O dracula-gtk-theme.zip
fi

if [ ! -f "ant-dracula-gtk-theme.zip" ]; then
  wget https://github.com/EliverLara/Ant-Dracula/archive/master.zip -O ant-dracula-gtk-theme.zip
fi

rm -rf ant-dracula-theme
rm -rf 
unzip ant-dracula-gtk-theme.zip
unzip dracula-gtk-theme.zip
sudo mv ant-dracula-theme /usr/share/themes/Ant-Dracula
# gsettings set org.gnome.desktop.interface gtk-theme "Ant-Dracula"
# gsettings set org.gnome.desktop.wm.preferences theme "Ant-Dracula"

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

exit 0
