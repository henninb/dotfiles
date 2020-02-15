#!/bin/sh

cd $HOME/projects || exit
git clone https://github.com/tryone144/compton.git
cd compton || exit
git checkout feature/dual_kawase
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

exit 0
