#!/bin/sh

#sudo apt install -y yarn
unset NVM_DIR

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

#https://github.com/yarnpkg/yarn/archive/v1.21.1.tar.gz

[ ! "$OS" = "Linux Mint" ] && source "$HOME/.nvm/nvm.sh"

# nvm install 10.16.0
echo logout and login
echo nvm install 13.8.0

exit 0

npm install -g yarn

sudo npm list -g --depth=0
sudo npm list -g --depth=1

# echo yarn add react
# yarn add coc-python
# yarn add coc-html
# yarn add coc-java
# yarn add coc-powershell
# yarn add coc-rls
# yarn add coc-svg
# yarn add coc-git
# yarn add coc-fsharp
# echo yarn add coc-gocode
# echo yarn add coc-eslint
# yarn add coc-xml
# yarn add coc-clojure
# yarn add coc-vimlsp
# yarn add coc-go
# yarn add coc-docker
# yarn add coc-elixir
# yarn add coc-lua
# yarn add coc-sql
# yarn add coc-angular
# yarn add coc-json
# yarn add coc-css
# yarn add coc-yaml
# yarn add eslint
# yarn add prettier
# yarn add eslint-plugin-prettier
# yarn add eslint-config-prettier

exit 0
