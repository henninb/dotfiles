#!/bin/sh

# for f in $(find . -type f -name "*.mp3" -print); do
#   # mp3info -a artist -t song file.mp3
#   echo  $f
# done

find . -type f -name '*.mp3' -exec sh -c '
  for file do
    echo "$file"
  done
' exec-sh {} +

exit 0
