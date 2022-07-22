#!/bin/sh

mkdir -p "$HOME/tmp"
sudo emerge -uDUN --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-world-$$.log"

exit 0
