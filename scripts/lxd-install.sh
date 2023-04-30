#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S lxc
  doas pacman --noconfirm --needed -S lxd
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v lxd; then
    doas emerge --update --newuse lxd
  fi
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

doas usermod -aG lxd "$(id -un)"
doas systemctl enable lxd
doas systemctl start lxd
sudo touch /etc/subuid
sudo touch /etc/subgid
doas usermod --add-subuids 100000-165535 root
doas usermod --add-subgids 100000-165535 root
doas lxd init

echo 'lxc image list images:'
echo 'lxc image list images: debian'
echo 'lxc launch ubuntu:22.04'
echo 'lxc launch images:centos/7 centos-7'

echo 'lxc exec archlinux -- pacman -S nginx'
echo 'lxc exec archlinux -- systemctl enable nginx'
echo 'lxc exec archlinux -- systemctl start nginx'
echo 'lxc list'
echo 'lxc start'
echo 'lxc stop'
echo 'lxc delete <name>'

exit 0

# vim: set ft=sh:
