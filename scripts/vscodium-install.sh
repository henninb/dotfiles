#!/bin/sh


if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  sudo emerge --update --newuse app-editors/vscodium
elif command -v xbps-install; then
  echo "void"
elif command -v pkg; then
  echo "freebsd"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  brew install vscodium
elif command -v apt; then
  echo "debian"
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
