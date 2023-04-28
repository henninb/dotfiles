#!/bin/sh

cd "$HOME/projects" || exit
git clone --recurse-submodules git@github.com:haskell/haskell-language-server.git
cd haskell-language-server || exit
stack ./install.hs hls

exit 0

# vim: set ft=sh:
