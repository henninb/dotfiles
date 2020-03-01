#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup --version > /dev/null && rustup update
rustup --version > /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#echo source $HOME/.cargo/env
echo git checkout .bash_profile  .profile .zprofile
echo cargo install ripgrep
echo cargo install dust
echo cargo install exa
echo cargo install broot
#echo cargo install alacritty

echo rustup default nightly
echo cargo install hunter
echo rustup default stable

cd projects || exit
git clone git@github.com:alacritty/alacritty.git
cd alacritty || exit
git pull origin master
cargo build --release

exit 0
