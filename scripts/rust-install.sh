#!/bin/sh

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y --no-modify-path
sudo apt install -y curl
sudo apt install -y cmake
sudo apt install -y g++
sudo apt install -y libexpat-dev

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init
chmod 755 rustup-init
./rustup-init -y --no-modify-path
rustup --version > /dev/null && rustup update
rustup --version > /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#echo source $HOME/.cargo/env
echo cargo install exa
echo cargo install leftwm
echo cargo install neovide
echo cargo install ttyper

echo rustup default nightly
echo cargo install hunter
echo rustup default stable

exit 0

# vim: set ft=sh:
