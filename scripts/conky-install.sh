#!/bin/sh

pkg-config --cflags freetype2
pkg-config --cflags xft

if command -v zypper; then
  sudo zypper install -y libXdamage-devel
  sudo zypper install -y lua-devel
  sudo zypper install -y imlib2-devel
#   sudo zypper install -y libXinerama-devel
#   sudo zypper install -y libXpm-devel
#   sudo zypper install -y libXft-devel
#   sudo zypper install -y freetype-devel
fi

mkdir -p "$HOME/projects/github.com/brndnmtthws"
cd "$HOME/projects/github.com/brndnmtthws" || exit
git clone https://github.com/brndnmtthws/conky.git
cd "$HOME/projects/github.com/brndnmtthws/conky" || exit
# make clean
# make
mkdir -p build
cd build
cmake ../
make
sudo make install
conky -version | head -1
# ls -l conky
# sudo make install

exit 0
