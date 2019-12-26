#!/bin/sh

# fedora setup
sudo dnf install alsa-lib-devel
echo dnf provides '*scrnsaver.h'
sudo dnf install libXScrnSaver-devel

curl -sSL https://get.haskellstack.org/ | sh

stack update
stack install ghc

stack install hlint

stack install xmobar
stack install xmonad-contrib
stack install xmonad-extras

 exit 0
