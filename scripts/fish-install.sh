#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  if ! command -v fish; then
    sudo emerge --update --newuse fish
  fi
elif command -v xbps-install; then
  echo "void"
elif command -v pkg; then
  sudo pkg install -y fish
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  brew install fish
elif command -v apt; then
  echo "debian"
else
  echo "$OS is not yet implemented."
  exit 1
fi

# fisher add matchai/spacefish

# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# fisher add matchai/spacefish

exit 0

# vim: set ft=sh:
