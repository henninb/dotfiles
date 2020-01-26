#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup --version &>/dev/null && rustup update
rustup --version &>/dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#echo source $HOME/.cargo/env
echo git checkout .bash_profile  .profile .zprofile

exit 0
