#!/bin/sh

echo markdown filename change underscores to dashes
for f in *.md; do git mv "$f" "$(echo "$f" | sed s/_/-/)"; done

echo rename files with spaces to underscores
rename 's/ /_/g' *.mp3
# for file in *.mp3; do mv -v "$file" "$(echo "$file" | tr '_' ' ')" ; done

# for f in *.mp3; do mv -v "$f" "$(echo "$f" | sed s/ /_/)"; done

exit 0

# can be changed
# vim: set ft=sh:
