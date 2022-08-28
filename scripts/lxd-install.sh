#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  if ! command -v lxd; then
    sudo emerge --update --newuse lxd
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

sudo usermod -aG lxd "$(id -un)"
sudo systemctl enable lxd
sudo systemctl start lxd
sudo lxd init
echo 'lxc image list images:'
echo 'lxc image list images: debian'
echo 'lxc launch ubuntu:22.04'
echo 'lxc launch images:centos/7 centos-7'

lxc list

exit 0

# vim: set ft=sh:
