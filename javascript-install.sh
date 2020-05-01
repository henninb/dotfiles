#!/bin/sh

#sudo apt install -y yarn
# unset NVM_DIR

# if [ ! -f "$HOME/.nvm" ]; then
#   git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
# fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y curl python-software-properties
  curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
  sudo apt install -y nodejs
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S nodejs
elif [ "$OS" = "void" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge  --update --newuse nodejs
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install nodejs
elif [ "$OS" = "CentOS Linux" ]; then
  echo centos
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y gcc python27 gmake
else
  echo "$OS is not yet implemented."
  exit 1
fi
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh

export NVM_DIR="$HOME/.nvm"

. "$HOME/.nvm/nvm.sh"
if [ $? -ne 0 ]; then
  source "$HOME/.nvm/nvm.sh"
fi

echo nvm install 13.8.0

if [ ! -x "$(command -v n)" ]; then
  sudo npm install -g n
fi
sudo n stable

exit 0
