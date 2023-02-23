#!/bin/sh

if command -v pacman; then
  sudo pacman --noconfirm --needed -S nginx
elif command -v emerge; then
  sudo emerge --update --newuse nginx
elif command -v apt; then
  sudo apt install -y nginx
elif command -v xbps-install; then
  sudo xbps-install -y nginx
elif command -v pkg; then
  sudo pkg install -y nginx
  sudo sysrc nginx_enable="YES"
  sudo service nginx start
elif command -v zypper; then
  sudo zypper install -y nginx
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
