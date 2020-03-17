#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libev-dev
  sudo apt install -y libasound2-dev
  sudo apt install -y libxcb1-dev 
  sudo apt install -y libxcb-keysyms1-dev
  sudo apt install -y libpango1.0-dev 
  sudo apt install -y libxcb-util0-dev 
  sudo apt install -y libxcb-icccm4-dev
  sudo apt install -y libyajl-dev 
  sudo apt install -y libstartup-notification0-dev 
  sudo apt install -y libxcb-randr0-dev 
  sudo apt install -y libev-dev
  sudo apt install -y libxcb-cursor-dev 
  sudo apt install -y libxcb-xinerama0-dev 
  sudo apt install -y libxcb-xkb-dev 
  sudo apt install -y libxkbcommon-dev
  sudo apt install -y libxkbcommon-x11-dev 
  sudo apt install -y autoconf
  sudo apt install -y xutils-dev
  sudo apt install -y libtool
  sudo apt install -y libcurl4-openssl-dev 
  sudo apt install -y python-xcbgen
  sudo apt install -y libxcb-xrm-dev
  sudo apt install -y libmpdclient-dev
  sudo apt install -y libiw-dev
  sudo apt install -y libpulse-dev
  sudo apt install -y libxcb-composite0-dev
  sudo apt install -y xcb-proto
  sudo apt install -y libxcb-ewmh-dev
  sudo apt install -y libssl-dev
fi


cd $HOME/projects/
git clone --recursive https://github.com/jaagr/polybar.git
cd polybar
./build.sh
cd $HOME

exit 0
