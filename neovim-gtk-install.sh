#!/bin/sh

cd "$HOME/projects"
git clone git@github.com:daa84/neovim-gtk.git
cd neovim-gtk
cargo build --release
mv target/release/nvim-gtk ~/.local/bin
cd -

exit 0
