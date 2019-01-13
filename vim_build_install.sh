#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  echo arch
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt remove -y vim
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum remove -y vim
  exit 1
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
else
  echo $OS is not yet implemented.
  exit 1
fi

cd projects

git clone https://github.com/vim/vim
cd vim
make
sudo make install
echo make install_local
make clean
cd $HOME

exit 0
