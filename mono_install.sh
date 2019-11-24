#!/bin/sh

pacman -S wine-mono

cd projects
git clone https://aur.archlinux.org/fsharp.git fsharp-aur
cd fsharp-aur
makepkg -si
cd -


exit 0
