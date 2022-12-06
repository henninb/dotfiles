#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'

  sudo apt install -y apt-transport-https
  sudo apt update -y
  sudo apt install -y dotnet-sdk-2.2
elif [ "$OS" = "Fedora Linux" ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo wget -q -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/fedora/30/prod.repo
  sudo dnf install dotnet-sdk-2.2
elif [ "$OS" = "CentOS Linux" ]; then
  sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
  sudo yum update
  sudo yum install dotnet-sdk-2.2
elif [ "$OS" = "Gentoo" ]; then
  #sudo mkdir -p /etc/portage/repos.conf
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo eselect repository enable dotnet
  sudo emaint -r dotnet sync
  sudo emerge emerge --autounmask-write --update --newuse dev-dotnet/dotnetcore-sdk-bin
  sudo emerge --autounmask-write '=dev-dotnet/dotnetcore-sdk-bin-6.0.102'
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S dotnet-sdk
else
  echo "$OS is not yet implemented."
  exit 1
fi

which dotnet

exit 0

# vim: set ft=sh:
