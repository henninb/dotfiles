#!/bin/sh

if [ "$OS" = "Solus" ]; then
  doas eopkg install -y pcmanfm
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  if ! command -v pcmanfm; then
    doas apt install -y pcmanfm
  fi
elif [ "$OS" = "ArcoLinux" ] || [ "$OS" = "Arch Linux" ]; then
  if ! command -v pcmanfm; then
    doas pacman --noconfirm --needed -S pcmanfm
  fi
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y pcmanfm
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v pcmanfm; then
    doas emerge  --update --newuse pcmanfm
  fi
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y pcmanfm
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install pcmanfm
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y pcmanfm
else
  echo "$OS is not implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
