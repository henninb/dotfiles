#!/bin/sh

sudo zypper install -y gtk3-devel
sudo apt install -y libgtk2.0-dev
sudo apt install -y libgtk-3-dev

cd "$HOME/projects" || exit
git clone git@github.com:mwh/dragon.git
cd dragon || exit
git pull origin master
make
make install
cd - || exit

exit 0
