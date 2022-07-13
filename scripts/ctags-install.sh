#!/bin/sh


cd "$HOME/projects" || exit

git clone git@github.com:enechaev/packcc.git
cd packcc || exit
gcc -o packcc packcc.c
mv packcc "$HOME/.local/bin"

cd "$HOME/projects" || exit
git clone git@github.com:universal-ctags/ctags.git
cd ctags || exit
./autogen.sh
./configure
make

exit 0

# vim: set ft=sh:
