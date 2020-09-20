#!/bin/sh

echo filetype

for file in *' '*ttf
do
  mv -- "$file" "${file// /_}"
  echo "$file"
done

exit 0

# can be changed
for f in *.md; do git mv "$f" "$(echo "$f" | sed s/_/-/)"; done
