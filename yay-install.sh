#!/bin/sh

cd projects || exit
git clone https://aur.archlinux.org/yay.git yay-aur
cd yay-aur || exit
makepkg -si
cd - || exit

exit 0
