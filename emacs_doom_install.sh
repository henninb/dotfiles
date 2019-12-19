#!/bin/sh

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom refresh


#cd projects
#git clone git@github.com:emacs-mirror/emacs.git
#cd emacs

#sudo add-apt-repository ppa:ubuntu-elisp/ppa
#sudo apt-get update
#sudo apt-get install emacs-snapshot
wget https://ftp.gnu.org/gnu/emacs/emacs-26.3.tar.xz
tar xvf emacs-26.3.tar.xz
cd emacs-26.3
./autocofig.sh
./configure --with-xpm=no --with-jpeg=no --with-gif=no --with-tiff=no

exit 0
