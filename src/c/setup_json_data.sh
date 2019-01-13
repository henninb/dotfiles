#!/bin/sh

scp pi@192.168.100.25:/home/pi/json_in.zip .

mkdir -p json_in
cd json_in
unzip -o ../json_in.zip
dos2unix  *.json
cd -

# cd $HOME/projects
# git clone git@github.com:DaveGamble/cJSON.git
# cd cJSON
# make
# sudo make install
# cd -

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman -S jansson
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y libjansson-dev
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge dev-libs/jansson
else
  echo $OS not implemented.
fi

exit 0
