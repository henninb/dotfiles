#!/bin/sh

wget https://gigenet.dl.sourceforge.net/project/libxls/libxls-old/libxls-0.2.0/libxls-0.2.0/libxls-0.2.0.tar.gz
sudo dnf install byacc
sudo apt install libncursesw5-dev

cd $HOME/projects
git clone git@github.com:andmarti1424/sc-im.git
cd $HOME/projects/sc-im
make -C src
sudo make -C src install

exit 0
