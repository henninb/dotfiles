#!/bin/sh

# export DZEN_XINERAMA
# export DZEN_XPM
# export DZEN_XFT
#export CFLAGS="-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT"
#
sudo zypper install -y libXinerama-devel
sudo zypper install -y libXpm-devel
sudo zypper install -y libXft-devel
sudo zypper install -y freetype-devel

mkdir -p "$HOME/projects/github.com/minos-org/"
cd "$HOME/projects/github.com/minos-org" || exit
git clone https://github.com/minos-org/dzen2.git
#git clone https://github.com/robm/dzen.git
cd dzen2 || exit
# sudo make clean install
# sudo make -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT clean install
make CFLAGS='-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT'
sudo make install
#cd - || exit
/usr/bin/dzen2 -v
ls -l /usr/bin/dzen2

exit 0
