#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  echo "gentoo"
elif command -v apt; then
  sudo "debian"
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

mkdir -p "$HOME/projects/github.com/jgm"
cd "$HOME/projects/github.com/jgm" || exit
git clone --recursive git@github.com:jgm/pandoc.git
cd pandoc || exit
stack setup
stack install
cd - || exit

exit 0

# vim: set ft=sh:
