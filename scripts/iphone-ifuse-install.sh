#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  if ! command -v ifuse; then
    sudo emerge --update --newuse ifuse
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

sudo mkdir -p /media/iphone
sudo idevicepair pair
sudo ifuse /media/iphone

exit 0
