#!/bin/sh

if [  "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libxml2-dev  libcurl4-openssl-dev libid3-3.8.3-dev
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S castget
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y id3lib-devel
  sudo eopkg install -y nghttp2-devel
  sudo eopkg install -y libssh2-devel
else
  echo "$OS is not yet implemented."
  exit 1
fi
wget http://savannah.nongnu.org/download/castget/castget-1.2.4.tar.bz2 -O castget-1.2.4.tar.bz2

tar xvf castget-1.2.4.tar.bz2

cd castget-1.2.4 || exit
./configure
make
sudo make install

exit 0
