#!/bin/sh

if [ "$OS" = "Void" ]; then
  echo xtools
  sudo xbps-install -y xtools
  sudo mkdir -p /usr/ports
  sudo chown "$USER" /usr/ports
  cd /usr/ports || exit

  git clone git@github.com:void-linux/void-packages.git

  cd void-packages || exit
  git pull
else
  echo "OS must be void"
  exit 1
fi

#/usr/ports/void-packages
exit 0

# vim: set ft=sh
