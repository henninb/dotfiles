#!/bin/sh

pkg-config --exists gtk+-3.0 && echo "gtk+ 3.0 is installed" || echo "gtk+ 3.0 is not installed"
pkg-config --exists gtk+-2.0 && echo "gtk+ 2.0 is installed" || echo "gtk+ 2.0 is not installed"

theme_path=/usr/share/themes
local_theme_path="$HOME/.themes"

mkdir -p "$HOME/.local/share/themes"
if [ ! -f "$HOME/tmp/dracula-gtk-theme.zip" ]; then
  wget "https://github.com/dracula/gtk/archive/master.zip" -O "$HOME/tmp/dracula-gtk-theme.zip"
  echo curl
fi

if [ ! -f "$HOME/tmp/ant-dracula-gtk-theme.zip" ]; then
  wget "https://github.com/EliverLara/Ant-Dracula/archive/master.zip" -O "$HOME/tmp/ant-dracula-gtk-theme.zip"
  echo curl
fi


echo 'git clone https://github.com/theory-of-everything/everforest-gtk ~/.themes/everforest-gtk'

cd "$HOME/tmp" || exit
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

sudo cp -rv "$theme_path/AntDracula" "$local_theme_path"
sudo cp -rv "$theme_path/Dracula" "$local_theme_path"

if ! gsettings set org.gnome.desktop.interface gtk-theme "Dracula"; then
  export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
  if ! gsettings set org.gnome.desktop.interface gtk-theme "Dracula"; then
    echo "cannot set the theme, check the dbus settings"
    exit 1
  fi
fi

if ! gsettings set org.gnome.desktop.wm.preferences theme "Dracula"; then
  export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
  if ! gsettings set org.gnome.desktop.wm.preferences theme "Dracula"; then
    echo "cannot set the theme, check the dbus settings"
    exit 1
  fi
fi

gsettings get org.gnome.desktop.wm.preferences theme
echo lxappearance
echo Gtk-WARNING **: 06:03:30.531: Theme parsing error: gtk-dark.css:5809:26: '-shadow' is not a valid color name
echo Gtk-WARNING **: 06:03:30.531: Theme parsing error: gtk-dark.css:5812:14: not a number
echo Gtk-WARNING **: 06:03:30.531: Theme parsing error: gtk-dark.css:5813:13: not a number
echo Gtk-WARNING **: 06:03:30.531: Theme parsing error: gtk-dark.css:5814:11: Expected a length
echo edit the file below to fix gtk warnings
echo vi /usr/share/themes/Dracula/gtk-3.20/gtk-dark.css

exit 0

# vim: set ft=sh:
