#!/bin/sh

sudo apt install libxcb-xinput-dev
sudo apt install libxcb-xtest0-dev
sudo apt install libx11-xcb-dev
sudo apt install trayer
sudo apt install copyq
sudo apt install volumeicon-alsa

cd "$HOME/projects" || exit
git clone git@github.com:conformal/spectrwm.git
cd spectrwm || exit
cd linux || exit
make
sudo make install

exit 0
