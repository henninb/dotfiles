#!/bin/sh


curl -sSL https://get.haskellstack.org/ | sh
stack update

stack install ShellCheck

if ! command -v shellcheck; then
  cd "$HOME/projects/github.com" || exit
  mkdir -p koalaman
  cd koalaman || exit
  #git clone https://github.com/koalaman/shellcheck.git
  git clone git@github.com:koalaman/shellcheck.git
  cd shellcheck || exit
  stack build
  stack install
fi

exit 0

# vim: set ft=sh:
