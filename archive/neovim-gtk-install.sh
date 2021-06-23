#!/bin/sh

cd "$HOME/projects" || exit
git clone git@github.com:daa84/neovim-gtk.git
cd neovim-gtk || exit
cargo build --release
mv target/release/nvim-gtk ~/.local/bin
cd - || exit

exit 0
