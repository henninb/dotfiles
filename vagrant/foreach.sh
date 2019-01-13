#!/bin/sh

for D in $(find . -mindepth 1 -maxdepth 1 -type d)
do
  touch $D/setup.sh
  git add -f  $D/setup.sh
done

exit 0
