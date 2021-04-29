#!/bin/sh

sudo pacman --noconfirm --needed -S fakeroot
sudo pacman --noconfirm --needed -S base-devel
mkdir -p projects
cd projects || exit
git clone https://aur.archlinux.org/yay.git yay-aur
cd yay-aur || exit
makepkg -si
cd - || exit

exit 0
