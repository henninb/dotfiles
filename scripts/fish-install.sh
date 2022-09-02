#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  if ! command -v fish; then
    sudo emerge --update --newuse fish
  fi
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

