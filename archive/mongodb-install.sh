#!/bin/sh

yay -S mongodb-bin
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

sudo systemctl enable mongodb
sudo systemctl start mongodb

exit 0
