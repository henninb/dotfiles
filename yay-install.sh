#!/bin/sh

cd projects
git clone https://aur.archlinux.org/yay.git yay-aur
cd yay-aur
makepkg -si
cd -

exit 0
