#!/bin/sh

# mint linux
sudo apt install -y qt5-qmake
sudo apt install -y libqt5sql5-sqlite
sudo apt install -y libqt5webkit5
sudo apt install -y libqt5x11extras5


# Qt >=5.5.1 with these modules
#     - libqt5sql5-sqlite
#     - libqt5webkit5 (must)
#     - libqt5x11extras5

sudo apt install -y mpv
sudo apt install -y coreutils
sudo apt install -y socat
#python >=2.7
sudo apt install -y wget
sudo apt install -y libtag1-dev
sudo apt install -y qt5-default
sudo apt install -y libqt5webkit5-dev

cd $HOME/projects
git clone git@github.com:keshavbhatt/olivia.git
cd olivia
qmake
make
sudo make install

exit 0
