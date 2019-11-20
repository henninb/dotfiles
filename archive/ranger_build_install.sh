#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  echo arch
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y gperf luajit luarocks libuv1-dev libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev cmake libtool-bin
  sudo apt remove -y neovim
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum remove -y neovim
  sudo yum install -y cmake libtool luajit luarocks
  sudo yum install -y yum install gcc-c++ patch
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
else
  echo $OS is not configured.
  exit 1
fi

cd projects

git clone git@github.com:ranger/ranger.git
cd ranger
#git checkout tags/v0.3.8
make
sudo make install
echo make install_local
sudo make clean
cd $HOME

exit 0
