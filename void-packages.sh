#!/bin/sh

echo xtools
sudo xbps-install -y xtools
sudo mkdir -p /usr/ports
sudo chown "$USER" /usr/ports
cd /usr/ports || exit

git clone git@github.com:void-linux/void-packages.git

cd void-packages || exit
git pull

#/usr/ports/void-packages
exit 0

# vim: set ft=sh
