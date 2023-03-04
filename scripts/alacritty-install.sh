#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  echo
elif [ -x "$(command -v emerge)" ]; then
  echo
elif [ -x "$(command -v apt)" ]; then
  sudo apt install libfreetype-dev cmake libfontconfig-dev
  sudo apt install -y libxcb-shape0-dev
  sudo apt install -y libxcb-xfixes0-dev
  sudo apt install -y libxkbcommon-dev
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y mesa-dri
elif [ -x "$(command -v pkg)" ]; then
  echo "freebsd"
elif [ -x "$(command -v eopkg)" ]; then
  echo "solus"
elif [ -x "$(command -v swupd)" ]; then
  sudo swupd bundle-add devpkg-freetype
  sudo swupd bundle-add devpkg-libxml2
  sudo swupd bundle-add devpkg-expat
  sudo swupd bundle-add performance-tools
  sudo swupd bundle-add devpkg-libxcb
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi


mkdir -p "$HOME/projects/github.com/alacritty"
cd "$HOME/projects/github.com/alacritty" || exit
git clone git@github.com:alacritty/alacritty.git
cd ./alacritty || exit
git pull origin master
cargo build --release
sudo mv -v target/release/alacritty /usr/local/bin

exit 0

# vim: set ft=sh:
