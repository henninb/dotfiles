#!/bin/sh

ver=3.1.1

if command -v pacman; then
  echo "archlinux"
  sudo pacman --noconfirm --needed -S fakeroot
  sudo pacman --noconfirm --needed -S rpm
elif command -v emerge; then
  echo "gentoo"
elif command -v apt; then
  sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
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
# echo https://github.com/fastly/cli/releases/tag/v3.1.1
echo "curl https://github.com/fastly/cli/releases/download/v${ver}/fastly_v${ver}_linux-amd64.tar.gz"
echo "https://github.com/fastly/cli/releases/download/v3.1.1/fastly_v3.1.1_darwin-amd64.tar.gz"
rm -rf "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz"
echo curl -k "https://github.com/fastly/cli/releases/download/v${ver}/fastly_v${ver}_linux-amd64.tar.gz" --output "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz"
curl -k "https://github.com/fastly/cli/releases/download/v${ver}/fastly_v${ver}_linux-amd64.tar.gz" --output "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz"
# curl -kI "https://github.com/fastly/cli/releases/download/v${ver}/fastly_v${ver}_linux-amd64.tar.gz"
sudo tar -xvf "$HOME/tmp/fastly_v${ver}_linux-amd64.tar.gz" -C /opt/fastly/bin


exit 0

# vim: set ft=sh:
