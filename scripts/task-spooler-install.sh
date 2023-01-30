#!/bin/sh

mkdir -p "$HOME/projects/github.com/xenogenesi"
cd "$HOME/projects/github.com/xenogenesi" || exit
git clone git@github.com:xenogenesi/task-spooler.git
cd task-spooler || exit
./configure
autoreconf -f -i
if ! make; then
  echo "failed to build task-spooler"
  exit 1
fi
sudo make install
sudo ln -sfn /usr/local/bin/ts /usr/local/bin/tsp

exit 0

# vim: set ft=sh:
