#!/bin/sh

sudo mkdir -p /usr/ports
sudo chown "$USER" /usr/ports
cd /usr/ports || exit

git clone git@github.com:void-linux/void-packages.git

cd void-packages || exit
git pull

#/usr/ports/void-packages
exit 0
