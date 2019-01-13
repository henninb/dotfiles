#!/bin/sh

sudo dnf install byacc

cd $HOME/projects
git clone git@github.com:andmarti1424/sc-im.git
cd $HOME/projects/sc-im
make -C src
sudo make -C src install

exit 0
