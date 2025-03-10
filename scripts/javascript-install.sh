#!/bin/sh

# curl -s 'https://nodejs.org/download/release/latest-v22.x/' | grep node | tail -1
curl -s 'https://nodejs.org/download/release/latest-v22.x/' | grep node | tail -1 | cut -d' ' -f2 | cut -d "-" -f 2  | sed 's/.tar.*//' | sed 's/v//'
node_ver=$(curl -s 'https://nodejs.org/download/release/latest-v22.x/' | grep node | tail -1 | cut -d' ' -f2 | cut -d "-" -f 2  | sed 's/.tar.*//' | sed 's/v//')
# node_ver=18.15.0
#sudo apt install -y yarn
# unset NVM_DIR

# if [ ! -f "$HOME/.nvm" ]; then
#   git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
# fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  doas apt install -y curl
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  doas apt install -y nodejs
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S npm nodejs
  exit 0
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y nodejs20
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y nodejs
elif [ "$OS" = "Alpine Linux" ]; then
  doas apk add curl nodejs npm
  doas apk add nodejs
elif [ "$OS" = "Darwin" ]; then
  test
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y nodejs
elif [ "$OS" = "Gentoo" ]; then
  doas emerge  --update --newuse nodejs
  exit 0
elif [ "$OS" = "Solus" ]; then
  echo sudo eopkg install nodejs
elif [ "$OS" = "CentOS Linux" ]; then
  echo centos
elif [ "$OS" = "FreeBSD" ]; then
  # sudo pkg install -y gcc
  # sudo pkg install -y gmake
  doas pkg install -y npm
  # sudo pkg install -y node16-16.16.0
  # npm install -g yarn
else
  echo "$OS is not yet implemented."
  exit 1
fi

curl -s -qL https://www.npmjs.com/install.sh | sh

echo "doesn't seem to work"
if ! command -v nvm; then
  echo "nvm is not in the path"
  curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sh
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  if ! nvm install "$node_ver"; then
    echo nvm failed.
    exit 1
  fi
fi

nvm install --lts --latest-npm

# Get the latest LTS version of Node.js
latest_lts_version=$(nvm ls-remote --lts | tail -1)

# Get a list of all installed LTS versions
installed_lts_versions=$(nvm ls --no-alias | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' | sort -V | grep -e '^[0-9]*\.[0-9]*\.[0-9]*$')

# Uninstall any installed LTS versions older than the latest LTS version
for version in $installed_lts_versions; do
    if [ "$version" != "$latest_lts_version" ]; then
        nvm uninstall $version && echo "Uninstalled older LTS version: $version"
    fi
done


# if ! command -v node; then
#   if ! nvm install "$node_ver"; then
#     echo nvm failed.
#     exit 1
#   fi
# fi
#
# nvm use "$node_ver"
# echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
# . ~/.bashrc
# mkdir ~/local
# mkdir ~/node-latest-install
# cd ~/node-latest-install
# curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
# ./configure --prefix=~/local
# make install # ok, fine, this step probably takes more than 30 seconds...
# curl https://www.npmjs.org/install.sh | sh

exit 0

# vim: set ft=sh:
