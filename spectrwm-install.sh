#!/bin/sh

sudo apt install -y libxcb-xinput-dev
sudo apt install -y libxcb-xtest0-dev
sudo apt install -y libx11-xcb-dev
sudo apt install -y libxcb-util-dev
sudo apt install -y libxcb-keysyms1-dev

sudo apt install -y trayer
sudo apt install -y copyq
sudo apt install -y volumeicon-alsa

cd "$HOME/projects" || exit
git clone git@github.com:conformal/spectrwm.git
cd spectrwm || exit
cd linux || exit
make
sudo make install

exit 0
