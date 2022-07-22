#!/bin/sh

if [ "$OS" = "Solus" ]; then
  sudo eopkg install -y pcmanfm
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y pcmanfm
elif [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S pcmanfm
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y pcmanfm
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge  --update --newuse pcmanfm
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y pcmanfm
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install pcmanfm
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y pcmanfm
else
  echo "$OS is not implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
