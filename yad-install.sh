#!/bin/sh

mkdir -p "$HOME/projects/github.com/v1cont"
cd "$HOME/projects/github.com/v1cont" || exit
git clone git@github.com:v1cont/yad.git
cd yad
autoreconf -ivf && intltoolize
./configure
make
sudo make install
cd - || exit

exit 0
