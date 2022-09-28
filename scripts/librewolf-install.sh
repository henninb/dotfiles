#!/bin/sh


if command -v pacman; then
  yay -S librewolf
elif command -v emerge; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo eselect repository add librewolf git https://gitlab.com/librewolf-community/browser/gentoo.git
  sudo emaint -r librewolf sync
  sudo emerge --update --newuse librewolf-bin
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
