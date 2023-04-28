#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  echo "arch"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y mlton
  exit 0
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y mlton
  exit 0
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse mlton
  exit 0
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo wget https://github.com/kfl/mosml/archive/ver-2.10.1.tar.gz -O mosml-2.10.1.tar.gz
echo tar xvf mosml-2.10.1.tar.gz
cd projects || exit
git clone git@github.com:kfl/mosml.git
cd mosml/src/config || exit
make
echo make install_local
sudo make install
cd "$HOME" || exit

cd projects || exit
git clone git@github.com:MLton/mlton.git

exit 0

# vim: set ft=sh:
