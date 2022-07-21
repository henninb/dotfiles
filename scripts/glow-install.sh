#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

#go get github.com/charmbracelet/glow
#git clone http://github.com/charmbracelet/glow

# git clone https://github.com/charmbracelet/glow.git
# cd glow
# go build

if command -v pacman; then
  echo "archlinux"
  sudo pacman --noconfirm --needed -S glow
elif command -v emerge; then
  echo "gentoo"
  echo https://github.com/charmbracelet/glow
  echo go get github.com/charmbracelet/glow
  git clone https://github.com/charmbracelet/glow.git
  cd glow || exit
  go build
  go install
  cd - || exit
  rm -rf glow
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
  sudo xbps-install -y rpm
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

which glow

exit 0

# vim: set ft=sh:
