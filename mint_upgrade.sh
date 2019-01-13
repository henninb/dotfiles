#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  echo "upgrade from 19.1 to 19.2"
  echo $VERSION
  cat /etc/lsb-release
  sudo sed -i 's/tessa/tina/g' /etc/apt/sources.list.d/official-package-repositories.list
  sudo apt update -y
  sudo apt dist-upgrade -y
  cat /etc/lsb-release
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
