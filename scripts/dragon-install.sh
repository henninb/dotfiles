#!/bin/sh

if [ "$OS" = "Solus" ]; then
  sudo eopkg install -y libgtk-2-devel
  sudo eopkg install -y libgtk-3-devel
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libgtk2.0-dev
  sudo apt install -y libgtk-3-dev
elif [ "$OS" = "Void" ]; then
  sudo xbps-install  gtk+3-devel
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y gtk3-devel
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse x11-libs/gtk+:2
  sudo emerge --update --newuse x11-libs/gtk+:3
else
  echo "$OS is not implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/mwh"
cd "$HOME/projects/github.com/mwh" || exit
git clone git@github.com:mwh/dragon.git
cd dragon || exit
git pull origin master
make
make install
cd - || exit

exit 0

# vim: set ft=sh:
