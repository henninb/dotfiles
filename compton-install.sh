#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S uthash
  sudo pacman --noconfirm --needed -S ninja
  sudo pacman --noconfirm --needed -S meson
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install libxcb-damage0-dev
  sudo apt install uthash-dev
  sudo apt install libxdg-basedir-dev
elif [ "$OS" = "void" ]; then
  sudo xbps-install -S m   meson ninja
else
  echo "$OS is not yet implemented."
  exit 1
fi


cd "$HOME/projects" || exit
git clone https://github.com/tryone144/compton.git
cd compton || exit
git pull origin master
git checkout feature/dual_kawase
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

exit 0
