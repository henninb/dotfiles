#!/bin/sh

echo filetype

for file in *' '*ttf
do
  mv -- "$file" "${file// /_}"
  echo $file
done

exit 0
