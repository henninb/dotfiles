#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  echo "gentoo"
elif command -v apt; then
  sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/Dbus --method org.freedesktop.DBus.ListNames

mkdir -p "$HOME/projects/github.com/dunst-project"
cd "$HOME/projects/github.com/dunst-project" || exit
git clone --recursive git@github.com:dunst-project/dunst.git
cd dunst || exit
make
sudo make install
cd - || exit

exit 0

# vim: set ft=sh:
