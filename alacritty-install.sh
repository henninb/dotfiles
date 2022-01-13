#!/bin/sh

sudo xbps-install -y mesa-dri
sudo apt install -y libxcb-shape0-dev
sudo apt install -y libxcb-xfixes0-dev
sudo apt install -y libxkbcommon-dev

sudo swupd bundle-add devpkg-freetype
sudo swupd bundle-add devpkg-libxml2
sudo swupd bundle-add devpkg-expat
sudo swupd bundle-add performance-tools
sudo swupd bundle-add devpkg-libxcb

mkdir -p "$HOME/projects/github.com/alacritty"
cd "$HOME/projects/github.com/alacritty" || exit
git clone git@github.com:alacritty/alacritty.git
cd ./alacritty || exit
git pull origin master
cargo build --release
sudo mv -v target/release/alacritty /usr/local/bin

# cd "$HOME/projects" || exit
# git clone https://github.com/sei40kr/tmux-airline-dracula.git
# cd - || exit

exit 0
