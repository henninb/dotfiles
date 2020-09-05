#!/bin/sh

sudo apt install -y libxcb-shape0-dev
sudo apt install -y libxcb-xfixes0-dev

sudo swupd bundle-add devpkg-freetype
sudo swupd bundle-add devpkg-libxml2
sudo swupd bundle-add devpkg-expat
sudo swupd bundle-add performance-tools
sudo swupd bundle-add devpkg-libxcb


cd projects || exit
rm -rf alacritty
git clone git@github.com:alacritty/alacritty.git
cd alacritty || exit
git pull origin master
git checkout v0.5.0
cargo build --release
#mv -v target/release/alacritty "$HOME/.local/bin"
sudo mv -v target/release/alacritty /usr/local/bin

exit 0
