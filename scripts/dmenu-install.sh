#!/bin/sh

mkdir -p "$HOME/projects/gitlab.com/dwt1"
cd "$HOME/projects/gitlab.com/dwt1" || exit
git clone git@gitlab.com:dwt1/dmenu-distrotube.git
cd dmenu-distrotube || exit
make
sudo mv -v dmenu dmenu_run "$HOME/.local/bin"

exit 0

# vim: set ft=sh:
