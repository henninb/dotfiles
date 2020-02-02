#!/bin/sh

if [ -x "$(command -v stack)" ]; then
  stack exec ghc-pkg -- list
else
  echo install stack
fi

exit 0
