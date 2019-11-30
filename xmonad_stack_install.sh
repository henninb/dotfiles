#!/bin/sh

curl -sSL https://get.haskellstack.org/ | sh

stack update
stack install ghc

stack install xmobar
stack install xmonad-contrib
stack install xmonad-extras

 exit 0
