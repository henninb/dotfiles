#!/bin/sh

for f in $(find . -type f -name "*.mp3" -print); do
  echo  $f
  # echo $f | awk '{split($0,a, "-"); print a[0]; a[1]}'
  artist=$(echo $f | awk '{split($0,a, "-"); print a[1];}' | sed 's/_/ /g' | sed 's/\.\///g' | awk '{$1=$1};1')
  song=$(echo $f | awk '{split($0,a, "-"); print a[2];}' | sed 's/\.mp3//g' | sed 's/_/ /g' | awk '{$1=$1};1')
  echo $artist
  echo $song
  # mp3info -a "$artist" -t "$song" "$f"
  mp3info "$f"
done

exit 0

# vim: set ft=sh:
