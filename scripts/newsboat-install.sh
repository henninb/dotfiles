#!/bin/sh


if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S stfl
  doas pacman --noconfirm --needed -S elinks
  doas pacman --noconfirm --needed -S cmus
  doas pacman --noconfirm --needed -S asciidoctor
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y newsboat
  doas apt install -y cmus
  doas apt install -y mpv
  doas apt install -y elinks
  doas apt install -y task-spooler
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse newsboat
  doas emerge --update --newuse cmus
  doas emerge --update --newuse mpv
  doas emerge --update --newuse elinks
  echo
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -y sqlite3-devel
  doas eopkg install -y stfl-devel
  doas eopkg install -y json-c-devel
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
doas make install
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
  doas make install
fi

exit 0

# vim: set ft=sh:
