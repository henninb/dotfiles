#!/bin/sh

if command -v pacman; then
  echo "archlinux"
  sudo pacman -noconfirm --needed -S mosquitto
elif command -v emerge; then
  echo "gentoo"
  sudo emerge --update --newuse mosquitto
elif command -v apt; then
  echo "debian"
  sudo apt install -y mosquitto mosquitto-clients
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

sudo systemctl enable mosquitto
sudo systemctl start mosquitto
sudo systemctl status mosquitto

echo port 1883
echo mosquitto_sub -h localhost -t test
echo mosquitto_pub -h localhost -t test -m "hello world"

exit 0

# vim: set ft=sh:
