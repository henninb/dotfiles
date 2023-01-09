#!/bin/sh
#
echo arch-install-scripts

# pacstrap arch-chroot base linux linux-firmware neovim
mkdir -p chroot-archlinux

sudo chmod 755 /usr/bin/pacman
sudo pacman -Sy archlinux-keyring
sudo pacstrap chroot-archlinux/ base linux linux-firmware
sudo chmod 0 /usr/bin/pacman

exit 0
