#!/bin/sh

mkdir -p $HOME/projects
cd $HOME/projects

git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si

exit 0
