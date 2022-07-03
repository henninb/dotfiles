#!/bin/sh

ver=3.1.0
# wget https://github.com/fastly/cli/releases/download/v1.3.0/fastly_1.3.0_linux_amd64.rpm

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S fakeroot
  sudo pacman --noconfirm --needed -S rpm
elif [ -x "$(command -v emerge)" ]; then
  echo
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y rpm
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

wget "https://github.com/fastly/cli/releases/download/v${ver}/fastly_${ver}_linux_amd64.rpm" -O "$HOME/projects/fastly_${ver}_linux_amd64.rpm"

# wget 'https://github.com/fastly/cli/archive/refs/tags/v1.4.0.tar.gz' -O ~/projects/fastly-v1.4.0.tar.gz
# cd ~/projects/ || exit
# tar xvf fastly-v1.4.0.tar.gz
# cd cli-1.3.0 || exit
# make
# make install
# rm -rf "$HOME/projects/fastly-v1.4.0.tar.gz"

sudo rpm -i --nodeps "$HOME/projects/fastly_${ver}_linux_amd64.rpm"

# mkdir ~/projects/edge
# cd ~/projects/edge || exit
# fastly compute init

exit 0

# vim: set ft=sh:
