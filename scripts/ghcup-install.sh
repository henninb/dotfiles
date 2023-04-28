#!/bin/sh

mkdir -p "$HOME/projects/github.com/haskell"
cd "$HOME/projects/github.com/haskell" || exit
git clone git@github.com:haskell/ghcup-hs.git
cd ghcup-hs || exit
stack build
stack install

ghcup install hls

exit 0
# vim: set ft=sh:
