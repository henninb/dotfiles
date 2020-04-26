#!/bin/sh

cd $HOME/projects
git clone https://aur.archlinux.org/mongodb-bin mongodb-bin-aur
cd mongodb-bin-aur
makepkg -si

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

sudo systemctl enable mongodb
sudo systemctl start mongodb

exit 0
