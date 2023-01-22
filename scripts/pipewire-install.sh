#!/bin/sh

if command -v pacman; then
  echo "archlinux"
  sudo pacman --noconfirm --needed -S pipewire-pulse
  sudo systemctl enable pipewire-pulse --now
  exit 0
elif command -v emerge; then
  echo "gentoo"
  sudo emerge --update --newuse pipewire
elif command -v apt; then
  sudo apt install -y pipewire
elif command -v xbps-install; then
  echo "void"
elif command -v pkg; then
  echo "freebsd"
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

systemctl --user enable pipewire.socket pipewire-pulse.socket
systemctl --user disable pipewire-media-session.service
systemctl --user --force enable wireplumber.service

pactl info

exit 0
