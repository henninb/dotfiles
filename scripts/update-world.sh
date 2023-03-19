#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  mkdir -p "$HOME/tmp"
  sudo emerge -uDUN --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-world-$$.log"
fi

exit 0
