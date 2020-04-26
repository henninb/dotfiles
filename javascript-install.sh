#!/bin/sh

#sudo apt install -y yarn
# unset NVM_DIR

# if [ ! -f "$HOME/.nvm" ]; then
#   git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
# fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  #sudo apt update -y
#  sudo apt install -y gcc yarn
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S yarn
elif [ "$OS" = "void" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  #echo "=sys-apps/yarn-1.15.2 ~amd64" | sudo tee -a /etc/portage/package.accept_keywords
  #echo "=dev-libs/openssl-1.1.1b-r2 ~amd64" | sudo tee -a /etc/portage/package.accept_keywords
  #echo "=dev-libs/openssl-1.1.1b-r2" | sudo tee -a /etc/portage/package.unmask
  cat /var/lib/portage/world | grep yarn
  #sudo emerge -pf sys-apps/yarn
  #sudo emerge -upDN sys-apps/yarn
  #sudo emerge sys-apps/yarn
elif [ "$OS" = "Solus" ]; then
  echo Solus
elif [ "$OS" = "CentOS Linux" ]; then
  echo centos
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y yarn gcc python27 gmake
  sudo pkg install -y yarn-node10-1.16.0
else
  echo $OS is not yet implemented.
  exit 1
fi
#cd ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh

export NVM_DIR="$HOME/.nvm"

. "$HOME/.nvm/nvm.sh"
if [ $? -ne 0 ]; then
  source "$HOME/.nvm/nvm.sh"
fi

# nvm install 10.16.0
# echo logout and login
nvm install 13.8.0

exit 0
