#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S emacs
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  wget https://ftp.gnu.org/gnu/emacs/emacs-26.3.tar.xz
  tar xvf emacs-26.3.tar.xz
  cd emacs-26.3
  ./autogen.sh
  ./configure --with-xpm=no --with-jpeg=no --with-gif=no --with-tiff=no
  make
  sudo make install
elif [ "$OS" = "Darwin" ]; then
  echo nops
elif [ "$OS" = "FreeBSD" ]; then
  echo noop
else
  echo $OS is not yet implemented.
  exit 1
fi

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom refresh

#cd projects
#git clone git@github.com:emacs-mirror/emacs.git
#cd emacs

#sudo add-apt-repository ppa:ubuntu-elisp/ppa
#sudo apt-get update
#sudo apt-get install emacs-snapshot

exit 0
