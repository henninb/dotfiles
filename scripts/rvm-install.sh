#!/bin/sh

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
sudo gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
#curl -sSL https://get.rvm.io | bash -s stable --ruby
chmod 700 "$HOME/.gnupg"
curl -sSL https://get.rvm.io | sudo bash -s stable
rvm requirements

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo usermod -a -G rvm "$(id -un)"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo usermod -a -G rvm "$(id -un)"
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
else
  echo "$OS is not yet implemented."
  exit 1
fi
exit 0

# vim: set ft=sh:
