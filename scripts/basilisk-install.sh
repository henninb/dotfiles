#!/bin/sh

mkdir -p "$HOME/projects/github.com/cebix"
cd "$HOME/projects/github.com/cebix" || exit
git clone https://github.com/cebix/macemu.git
cd macemu/BasiliskII/src/Unix || exit
./autogen.sh
./configure
make
doas make install

exit 0

# vim: set ft=sh:
