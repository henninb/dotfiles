#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  if ! sudo grep -q "^henninb ALL=(ALL:ALL) NOPASSWD: ALL$" /etc/sudoers; then
    echo "henninb ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "added henninb to /etc/sudoers"
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  if ! sudo grep -q "^henninb ALL=(ALL:ALL) NOPASSWD: ALL$" /etc/sudoers; then
    echo "henninb ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "added henninb to /etc/sudoers"
  fi
elif [ "$OS" = "Void" ]; then
  if ! sudo grep -q "^henninb ALL=(ALL:ALL) NOPASSWD: ALL$" /etc/sudoers; then
    echo "henninb ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "added henninb to /etc/sudoers"
  fi
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  if ! sudo grep -q "^henninb ALL=(ALL:ALL) NOPASSWD: ALL$" /etc/sudoers; then
    echo "henninb ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "added henninb to /etc/sudoers"
  fi
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
