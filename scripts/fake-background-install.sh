#!/bin/sh

if command -v pacman; then
  sudo pacman --noconfirm --needed -S v4l2loopback-dkms
elif command -v emerge; then
  sudo emerge --update --newuse media-video/v4l2loopback
elif command -v apt; then
  echo "debian"
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

mkdir -p "$HOME/projects/github.com/fangfufu"
cd "$HOME/projects/github.com/fangfufu" || exit
git clone https://github.com/fangfufu/Linux-Fake-Background-Webcam.git fake-background
cd fake-background
./install.sh
echo install pip3
echo cd "$HOME/projects/github.com/fangfufu/fake-background"
echo ./fake.py --no-foreground --width 640 --height 480 --background-blur 0

exit 0

# vim: set ft=sh:
