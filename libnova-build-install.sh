#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  echo "arch"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "CentOS Linux" ]; then
  echo "cent"
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse $i
  exit 0
else
  echo $OS is not yet implemented.
  exit 1
fi

cd projects
git clone git://git.code.sf.net/p/libnova/libnova libnova
cd libnova
./autogen.sh
./configure
make
make install_local
sudo make install

exit 0
