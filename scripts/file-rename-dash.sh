#!/bin/sh

# List files with spaces or capital letters
for file in *\ * *[[:upper:]]*
do
  # Replace spaces with dashes in filename
  newname=`echo $file | tr ' ' '-' | tr '[:upper:]' '[:lower:]'`

  # Remove multiple dashes in filename
  newname=`echo $newname | sed 's/-\{2,\}/-/g'`

  # Rename file
  if [ "$file" != "$newname" ]; then
    mv "$file" "$newname"
  fi
done

# List renamed files
ls

exit 0
