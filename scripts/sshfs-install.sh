#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed sshfs
elif [ "$OS" = "Gentoo" ]; then
  echo "gentoo"
  sudo emerge --update --newuse sshfs
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/mnt/downloads"
mkdir -p "$HOME/mnt/audio"
echo sshfs pi@raspi:/home/pi/downloads ~/mnt/downloads -o reconnect
sshfs pi@raspi:/home/pi/downloads ~/mnt/downloads -o reconnect

echo sshfs henninb@hornsup:/home/henninb/src/api/youtube/audio ~/mnt/audio -o reconnect
sshfs henninb@hornsup:/home/henninb/src/api/youtube/audio ~/mnt/audio -o reconnect

exit 0

# vim: set ft=sh
