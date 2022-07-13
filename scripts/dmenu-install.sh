#!/bin/sh

cd "$HOME/projects" || exit
git clone git@gitlab.com:dwt1/dmenu-distrotube.git
cd dmenu-distrotube || exit
make
sudo mv -v dmenu dmenu_run /usr/local/bin/
cd "$HOME" || exit

exit 0

# vim: set ft=sh:
