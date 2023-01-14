#!/bin/sh

if [ "$OS" = "Solus" ]; then
  sudo eopkg install -y pcmanfm
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  if ! command -v pcmanfm; then
    sudo apt install -y pcmanfm
  fi
elif [ "$OS" = "ArcoLinux" ] || [ "$OS" = "Arch Linux" ]; then
  if ! command -v pcmanfm; then
    sudo pacman --noconfirm --needed -S pcmanfm
  fi
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y pcmanfm
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v pcmanfm; then
    sudo emerge  --update --newuse pcmanfm
  fi
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y pcmanfm
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install pcmanfm
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y pcmanfm
else
  echo "$OS is not implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
