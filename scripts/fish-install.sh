#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "Gentoo" ]; then
  echo "gentoo"
  if ! command -v fish; then
    sudo emerge --update --newuse fish
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y fish
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y fish
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y fish
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y fish
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
  sudo dnf install -y fish
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  brew install fish
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
