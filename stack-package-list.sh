#!/bin/sh

curl -sSL https://get.haskellstack.org/ | sh
stack update

if [ -x "$(command -v stack)" ]; then
  stack exec ghc-pkg -- list
else
  echo install stack
fi

exit 0

# vim: set ft=sh
