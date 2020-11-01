#!/bin/sh

mkdir "$HOME/.themes"
if [ ! -f "dracula-gtk-theme.zip" ]; then
  wget https://github.com/dracula/gtk/archive/master.zip -O dracula-gtk-theme.zip
fi

if [ ! -f "ant-dracula-gtk-theme.zip" ]; then
  wget https://github.com/EliverLara/Ant-Dracula/archive/master.zip -O ant-dracula-gtk-theme.zip
fi

rm -rf ant-dracula-theme ant-dracula-gtk-theme
rm -rf gtk-master dracula-gtk-theme

unzip -o ant-dracula-gtk-theme.zip
mv -v gtk-master ant-dracula-gtk-theme
unzip -o dracula-gtk-theme.zip
mv -v gtk-master dracula-gtk-theme

if [ ! -d "$HOME/.themes/dracula-gtk-theme" ]; then
  mv -v dracula-gtk-theme "$HOME/.themes"
fi

if [ ! -d "$HOME/.themes/ant-dracula-gtk-theme" ]; then
  mv -v ant-dracula-gtk-theme "$HOME/.themes"
fi

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

exit 0

# sudo mv ant-dracula-theme /usr/share/themes/Ant-Dracula
# gsettings set org.gnome.desktop.interface gtk-theme "Ant-Dracula"
# gsettings set org.gnome.desktop.wm.preferences theme "Ant-Dracula"
