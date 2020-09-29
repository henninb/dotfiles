#!/bin/sh

sudo apt install -y libxcb-xinput-dev
sudo apt install -y libxcb-xtest0-dev
sudo apt install -y libx11-xcb-dev
sudo apt install -y libxcb-util-dev
sudo apt install -y libxcb-keysyms1-dev
sudo apt install -y libxt-dev

# sudo eopkg install -y xcb-util-keysyms
sudo eopkg install -y xcb-util-keysyms-devel
sudo eopkg install -y libxt-devel

#sudo apt install -y trayer
sudo apt install -y copyq
sudo apt install -y volumeicon-alsa

echo arandr

cd "$HOME/projects" || exit
git clone git@github.com:conformal/spectrwm.git
cd spectrwm || exit
#patch spectrwm.c "$HOME/patch-spectrwm.c"
cd linux || exit
make
sudo make install

exit 0
