#!/bin/sh

 for song in $(ls -1 audio/*.mp3); do
  echo "$song"
  ffprobe -i "$song" 2> >(grep  missing 1>&2)
  id3v2 --list "$song"
  ffprobe -hide_banner -i "${song}" 2> >(grep  Stream 1>&2)
 done

 exit 0
