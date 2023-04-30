#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "arch"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "CentOS Linux" ]; then
  echo "cent"
elif [ "$OS" = "Gentoo" ]; then
  echo sudo emerge --update --newuse
  exit 0
else
  echo "$OS is not yet implemented."
  exit 1
fi

cd "$HOME/projects" || exit
git clone git://git.code.sf.net/p/libnova/libnova libnova
cd libnova || exit
./autogen.sh
./configure
make
make install_local
doas make install

exit 0

# vim: set ft=sh:
