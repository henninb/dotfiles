#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  echo
elif [ -x "$(command -v emerge)" ]; then
  echo
elif [ -x "$(command -v apt)" ]; then
  sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
elif [ -x "$(command -v xbps-install)" ]; then
  echo
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/dunst-project"
cd "$HOME/projects/github.com/dunst-project" || exit
git clone --recursive git@github.com:dunst-project/dunst.git
cd dunst || exit
make
sudo make install
cd - || exit

exit 0

# vim: set ft=sh:
