#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  echo "need to fix"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  sudo mv PowerlineSymbols.otf /usr/share/fonts/
  sudo fc-cache -vf
  sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
  sudo pacman -S powerline
  exit 0
elif [ "$OS" = "Linux Mint" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sudo apt install powerline
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  sudo mv PowerlineSymbols.otf /usr/share/fonts/
  sudo fc-cache -vf
  sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
else
  echo "OS not found"
fi

exit 0
