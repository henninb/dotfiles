#!/bin/sh

cd projects || exit
git clone git@github.com:alacritty/alacritty.git
cd alacritty || exit
git pull origin master
git checkout v0.4.2
cargo build --release
#mv -v target/release/alacritty "$HOME/.local/bin"
sudo mv -v target/release/alacritty /usr/local/bin

exit 0
