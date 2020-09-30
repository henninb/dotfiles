#!/bin/sh

if [ "$OS" = "Solus" ]; then
  # sudo eopkg install -y xcb-util-keysyms
  sudo eopkg install -y xcb-util-keysyms-devel
  sudo eopkg install -y libxt-devel
  sudo eopkg install -y gettext-devel
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libxcb-xinput-dev
  sudo apt install -y libxcb-xtest0-dev
  sudo apt install -y libx11-xcb-dev
  sudo apt install -y libxcb-util-dev
  sudo apt install -y libxcb-keysyms1-dev
  sudo apt install -y libxt-dev
  sudo apt install -y copyq
  sudo apt install -y volumeicon-alsa
elif [ "$OS" = "Gentoo" ]; then
  echo
else
  echo "$OS is not yet implemented."
fi


echo arandr

cd "$HOME/projects" || exit
git clone git@github.com:conformal/spectrwm.git
cd spectrwm || exit
#patch spectrwm.c "$HOME/patch-spectrwm.c"
cd linux || exit
make
sudo make install
cd "$HOME" || exit

cd "$HOME/projects" || exit
git clone git@github.com:Maato/volumeicon.git
cd volumeicon || exit
./autogen.sh
./configure
make
sudo make install
cd "$HOME" || exit

exit 0
