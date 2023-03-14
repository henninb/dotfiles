#!/bin/sh

ver=7.0.1

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "Gentoo" ]; then
  echo "gentoo"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
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
