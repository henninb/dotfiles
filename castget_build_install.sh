#!/bin/sh


if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y libxml2-dev  libcurl4-openssl-dev libid3-3.8.3-dev
elif [ \( "$OS" = "Arch Linux" \) -o \( "$OS" = "Manjaro Linux" \) ]; then
  sudo pacman --noconfirm --needed -S castget
else
  echo $OS is not yet implemented.
  exit 1
fi
wget http://savannah.nongnu.org/download/castget/castget-1.2.4.tar.bz2 -O castget-1.2.4.tar.bz2

tar xvf castget-1.2.4.tar.bz2

cd castget-1.2.4
./configure
make
sudo make install

exit 0
