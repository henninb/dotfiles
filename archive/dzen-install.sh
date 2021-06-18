#!/bin/sh
export DZEN_XINERAMA
export CFLAGS="-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT"
  cd "$HOME/projects" || exit
  # git clone https://github.com/minos-org/dzen2.git
  git clone https://github.com/robm/dzen.git
  cd dzen2 || exit
  sudo make clean install
  # sudo make -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT clean install
  cd - || exit
exit 0
