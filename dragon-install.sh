#!/bin/sh

cd "$HOME/projects" || exit
git clone git@github.com:mwh/dragon.git
cd dragon || exit
make
make install
cd - || exit

exit 0
