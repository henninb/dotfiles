#!/bin/sh


if [ "$OS" = "Gentoo" ]; then
  echo
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  #sudo apt install -y rxvt-unicode xsel
  echo
elif [ "$OS" = "FreeBSD" ]; then
  echo
elif [ "$OS" = "Ubuntu" ]; then
  echo
elif [ "$OS" = "Fedora" ]; then
  echo
elif [ "$OS" = "Linux Mint" ]; then
  echo
elif [ "$OS" = "Arch Linux" ]; then
  echo
else
  echo $OS is not yet implemented.
  exit 1
fi

cd $HOME/projects
git clone https://git.suckless.org/st
cd st
make
if [ $? -ne 0 ]; then
  echo "make failed."
  exit 1
fi
sudo make install
cd $HOME

cd $HOME/projects
git clone git@github.com:Tharre/st-transparency.git
cd st-transparency
make
if [ $? -ne 0 ]; then
  echo "make failed."
  exit 1
fi
mv st $HOME/.local/bin/st-transparency
cd $HOME

exit 0

