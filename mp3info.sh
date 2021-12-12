#!/bin/sh

for f in $(find . -type f -name "*.mp3"); do
  # mp3info -a artist -t song file.mp3
  echo  $f
done

exit 0
