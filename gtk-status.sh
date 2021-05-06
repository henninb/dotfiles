#!/bin/sh

if [ "$OS" = "Solus" ]; then
  sudo eopkg install -y libgtk-2-devel
  sudo eopkg install -y libgtk-3-devel
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libgtk2.0-dev
  sudo apt install -y libgtk-3-dev
elif [ "$OS" = "FreeBSD" ]; then
  echo
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y gtk3-devel
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse x11-libs/gtk+:2
  sudo emerge --update --newuse x11-libs/gtk+:3
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo
else
  echo "$OS is not implemented."
fi

pkg-config --exists gtk+-3.0 && echo "gtk+ 3.0 is installed" || echo "gtk+ 3.0 is not installed"
pkg-config --exists gtk+-2.0 && echo "gtk+ 2.0 is installed" || echo "gtk+ 2.0 is not installed"

exit 0
