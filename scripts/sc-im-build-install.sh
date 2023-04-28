#!/bin/sh

# wget https://gigenet.dl.sourceforge.net/project/libxls/libxls-old/libxls-0.2.0/libxls-0.2.0/libxls-0.2.0.tar.gz

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  echo "sudo emerge --update --newuse"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install libncursesw5-dev
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y byacc
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/andmarti1424"
cd "$HOME/projects/github.com/andmarti1424" || exit
git clone git@github.com:andmarti1424/sc-im.git
cd sc-im || exit
make -C src
sudo make -C src install

exit 0

# vim: set ft=sh:
