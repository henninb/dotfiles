#!/bin/sh

sudo dnf install mono-complete
sudo acman -S wine-mono

cd projects
git clone https://aur.archlinux.org/fsharp.git fsharp-aur
cd fsharp-aur
makepkg -si
cd -


exit 0
