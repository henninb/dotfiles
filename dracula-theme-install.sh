#!/bin/sh

pkg-config --exists gtk+-3.0 && echo "gtk+ 3.0 is installed" || echo "gtk+ 3.0 is not installed"
pkg-config --exists gtk+-2.0 && echo "gtk+ 2.0 is installed" || echo "gtk+ 2.0 is not installed"

theme_path=/usr/share/themes
mkdir -p "$HOME/.local/share/themes"
if [ ! -f "dracula-gtk-theme.zip" ]; then
  wget https://github.com/dracula/gtk/archive/master.zip -O dracula-gtk-theme.zip
fi

if [ ! -f "ant-dracula-gtk-theme.zip" ]; then
  wget https://github.com/EliverLara/Ant-Dracula/archive/master.zip -O ant-dracula-gtk-theme.zip
fi

rm -rf ant-dracula-theme AntDracula
rm -rf gtk-master Dracula

unzip -oq ant-dracula-gtk-theme.zip
mv -v gtk-master AntDracula
unzip -oq dracula-gtk-theme.zip
mv -v gtk-master Dracula

if [ ! -d "$theme_path/Dracula" ]; then
  sudo mv -v Dracula "$theme_path"
fi

if [ ! -d "$theme_path/AntDracula" ]; then
  sudo mv -v AntDracula "$theme_path"
fi

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
if ! gsettings set org.gnome.desktop.interface gtk-theme "Dracula"; then
  echo "cannot set the theme, check the dbus settings"
  exit 1
fi

if ! gsettings set org.gnome.desktop.wm.preferences theme "Dracula"; then
  echo "cannot set the theme, check the dbus settings"
  exit 1
fi

gsettings get org.gnome.desktop.wm.preferences theme
echo lxappearance

exit 0
