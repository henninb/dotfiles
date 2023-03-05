#!/bin/sh

ver=7.0.1

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  echo "gentoo"
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

sudo mkdir -p /opt/fastly/bin
rm -rf "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz"
curl --location -s "https://github.com/fastly/cli/releases/download/v${ver}/fastly_v${ver}_linux-amd64.tar.gz" --output "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz"
sudo tar -xvf "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz" -C /opt/fastly/bin
which fastly

exit 0

# vim: set ft=sh:
