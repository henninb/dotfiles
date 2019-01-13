#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman -S ncurses-devel
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install ncurses-dev
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y ncurses-devel
elif [ "$OS" = "Gentoo" ]; then
  echo sudo emerge sys-libs/ncurses
else
  echo $OS is not yet implemented.
  exit 1
fi

if [ ! -f bitchx-1.2.1.tar.gz ]; then
  wget http://www.bitchx.com/download/bitchx-1.2.1.tar.gz
fi

cd projects
tar xvf ../bitchx-1.2.1.tar.gz
cd bitchx-1.2.1
./configure
make
make install_local
sudo make install
cd

exit 0
