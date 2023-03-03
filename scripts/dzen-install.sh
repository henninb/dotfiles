#!/bin/sh

# export DZEN_XINERAMA
# export DZEN_XPM
# export DZEN_XFT
#export CFLAGS="-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT"
#
if command -v zypper; then
  sudo zypper install -y libXinerama-devel
  sudo zypper install -y libXpm-devel
  sudo zypper install -y libXft-devel
  sudo zypper install -y freetype-devel
fi

mkdir -p "$HOME/projects/github.com/minos-org"
cd "$HOME/projects/github.com/minos-org" || exit
git clone https://github.com/minos-org/dzen2.git
#git clone https://github.com/robm/dzen.git
cd "$HOME/projects/github.com/minos-org/dzen2" || exit
# sudo make clean install
# sudo make -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT clean install
make CFLAGS='-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT'
#sudo make
./dzen2 -v
ls -l dzen2

mkdir -p "$HOME/projects/github.com/robm"
cd "$HOME/projects/github.com/robm" || exit
git clone https://github.com/robm/dzen.git
cd dzen || exit
# sudo make clean install
# sudo make -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT clean install
#make clean
make CFLAGS='-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT'
./dzen2 -v
ls -l dzen2

exit 0
