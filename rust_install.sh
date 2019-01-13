#!/bin/sh

rustup --version &>/dev/null && rustup update
rustup --version &>/dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#echo source $HOME/.cargo/env

exit 0
