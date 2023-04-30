#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S fakeroot
  doas pacman --noconfirm --needed -S base-devel
  mkdir -p "$HOME/projects/archlinux.org/aur/"
  cd "$HOME/projects/archlinux.org/aur/" || exit
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  makepkg -si
  cd - || exit
fi

yay --noconfirm --needed -S downgrade

exit 0

# vim: set ft=sh:
