#!/bin/sh

export SDKMAN_DIR="$HOME/.sdkman"

if [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y zip unzip
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed  -S zip unzip
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse zip unzip
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y zip unzip
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y zip unzip
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y zip unzip
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y zip unzip
else
  echo "$OS not configured."
  exit 1
fi
curl -s "https://get.sdkman.io" > sdkman.sh
sh ./sdkman.sh

exit 1
#zsh -c 'source ./.sdkman/bin/sdkman-init.sh'
. ./.sdkman/bin/sdkman-init.sh
source ./.sdkman/bin/sdkman-init.sh

echo sdk install groovy
echo sdk install gradle
echo sdk install maven

echo sdk list java
echo sdk install java 9.0.4-open
echo sdk install java 10.0.2-open
echo sdk install java 11.0.2-open
echo sdk install java 12.0.1-open

exit 0

# vim: set ft=sh:
