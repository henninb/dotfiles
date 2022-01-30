#!/bin/sh

#sudo apt install -y yarn
# unset NVM_DIR

# if [ ! -f "$HOME/.nvm" ]; then
#   git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
# fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y curl
  curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt install -y nodejs
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo sudo pacman --noconfirm --needed -S nodejs
  echo sudo pacman --noconfirm --needed -S npm
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y nodejs
  echo
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
  sudo pkg install -y npm
  exit 0
else
  echo "$OS is not yet implemented."
  exit 1
fi
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | zsh

export NVM_DIR="$HOME/.nvm"

chmod 755 "$HOME/.nvm/nvm.sh"
zsh -c 'source ./.nvm/nvm.sh'
. ./.nvm/nvm.sh
source ./.nvm/nvm.sh
#. "$HOME/.nvm/nvm.sh"
#if [ $? -ne 0 ]; then
#  source "$HOME/.nvm/nvm.sh"
#fi

if ! nvm install 16.13.0; then
  sudo nvm install 16.13.0
fi
nvm use 16.13.0

[ ! -x "$(command -v npm)" ] && echo "npm is not installed." && exit 1
if [ ! -x "$(command -v n)" ]; then
  if ! npm install n; then
    sudo npm install -g n
    sudo n stable
  else
    n stable
  fi
fi

exit 0
