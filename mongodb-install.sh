#!/bin/sh

yay -S mongodb-bin
# yay -S mongodb-tools
yay -S mongodb-tools-bin
# wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

sudo systemctl enable mongodb
sudo systemctl start mongodb

echo mongo

exit 0

# vim: set ft=sh
