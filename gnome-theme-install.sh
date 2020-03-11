#!/bin/sh

wget https://github.com/EliverLara/Ant-Dracula/archive/master.zip
gsettings set org.gnome.desktop.interface gtk-theme "Ant-Dracula"                                                                    -- INSERT --
gsettings set org.gnome.desktop.wm.preferences theme "Ant-Dracula"

exit 0
