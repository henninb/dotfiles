#!/bin/sh

echo wget https://github.com/EliverLara/Ant-Dracula/archive/master.zip
unzip ant-dracula-theme.zip
sudo mv ant-dracula-theme /usr/share/themes/Ant-Dracula
gsettings set org.gnome.desktop.interface gtk-theme "Ant-Dracula"                                                                    -- INSERT --
gsettings set org.gnome.desktop.wm.preferences theme "Ant-Dracula"

exit 0
