#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  echo "upgrade from 19.3 Tricia to 20.0 Ulyana"
  echo "$VERSION"
  cat /etc/lsb-release
  #sudo sed -i 's/tessa/tina/g' /etc/apt/sources.list.d/official-package-repositories.list
  sudo apt install mintupgrade -y
  sudo sed -i 's/tricia/ulyana/g' /etc/apt/sources.list.d/official-package-repositories.list
  sudo apt update -y
  sudo apt dist-upgrade -y
  cat /etc/lsb-release
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
