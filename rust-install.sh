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
echo cargo install ripgrep
echo cargo install dust
echo cargo install exa
echo cargo install broot
#echo cargo install alacritty
echo cargo install fd-find
echo cargo install leftwm

echo rustup default nightly
echo cargo install hunter
echo rustup default stable

# cd projects || exit
# git clone git@github.com:alacritty/alacritty.git
# cd alacritty || exit
# git pull origin master
# cargo build --release
# sudo mv -v target/release/alacritty /usr/local/bin

exit 0
