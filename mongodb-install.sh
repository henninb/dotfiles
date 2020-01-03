#!/bin/sh

cd $HOME/projects
git clone https://aur.archlinux.org/mongodb-bin mongodb-bin-aur
cd mongodb-bin-aur
makepkg -si

sudo systemctl enable mongodb
sudo systemctl start mongodb
