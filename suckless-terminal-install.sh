#!/bin/sh


if [ "$OS" = "Gentoo" ]; then
  echo
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  #sudo apt install -y rxvt-unicode xsel
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
if [ $? -ne 0 ]; then
  echo "wget failed."
  exit 1
fi
cd st
if [ $? -ne 0 ]; then
  echo "cd failed."
  exit 1
fi
make
if [ $? -ne 0 ]; then
  echo "make failed."
  exit 1
fi
sudo make install
cd $HOME

exit 0

