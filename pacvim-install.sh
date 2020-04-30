#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install libcurses5-dev
elif [ \( "$OS" = "Arch Linux" \) -o \( "$OS" = "Manjaro Linux" \) ]; then
  sudo pacman  --noconfirm --needed -S libcurses5
else
  echo $OS is not yet implemented.
  exit 1
fi

git clone https://github.com/jmoon018/PacVim.git
cd PacVim
make
sudo make install

exit 0
