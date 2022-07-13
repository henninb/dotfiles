#!/bin/sh


if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S stfl
  sudo pacman --noconfirm --needed -S elinks
  sudo pacman --noconfirm --needed -S cmus
  sudo pacman --noconfirm --needed -S asciidoctor
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y newsboat
  sudo apt install -y cmus
  sudo apt install -y mpv
  sudo apt install -y elinks
  sudo apt install -y task-spooler
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse newsboat
  sudo emerge --update --newuse cmus
  sudo emerge --update --newuse mpv
  sudo emerge --update --newuse elinks
  echo
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y sqlite3-devel
  sudo eopkg install -y stfl-devel
  sudo eopkg install -y json-c-devel
# sudo eopkg install -y asciidoc
else
  echo "OS=$OS not setup yet."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/xenogenesi"
cd "$HOME/projects/github.com/xenogenesi" || exit
git clone git@github.com:xenogenesi/task-spooler.git
cd task-spooler || exit
./configure
autoreconf -f -i
if ! make; then
  echo "failed to build task-spooler"
  exit 1
fi
sudo make install
sudo ln -sfn /usr/local/bin/ts /usr/local/bin/tsp

if [ ! -x "$(command -v newsboat)" ]; then
  mkdir -p "$HOME/projects/github.com/newsboat"
  cd "$HOME/projects/github.com/newsboat" || exit
  git clone git@github.com:newsboat/newsboat.git
  cd newsboat || exit
  make
  if ! make; then
    echo "failed to build newsboat"
    exit 1
  fi
  sudo make install
fi

exit 0

# vim: set ft=sh:
