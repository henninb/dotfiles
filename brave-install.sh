#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install apt-transport-https curl
  curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
  echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt -y update
  sudo apt install -y brave-browser
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  yay -S brave-bin
elif [ "$OS" = "Gentoo" ]; then
  sudo eselect repository enable brave-overlay
  sudo emerge --sync
  echo "www-client/brave-bin **" | sudo tee -a /etc/portage/package.accept_keywords
  sudo emerge www-client/brave-bin
elif [ "$OS" = "fedora" ]; then
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser
else
  echo "$OS is not yet implemented."
fi

exit 0
