#!/bin/sh

cd projects || exit
git clone git@github.com:alacritty/alacritty.git
cd alacritty || exit
git pull origin master
cargo build --release
cp target/release/alacritty "$HOME/.local/bin"

exit 0
