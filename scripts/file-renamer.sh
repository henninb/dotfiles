#!/bin/sh

#for pem in /etc/ssl/certs/*.pem; do
for file in *; do
  if [ -f "$file" ] && [ ! "$file" = "file-renamer.sh" ]; then
    hash=$(md5sum "$file"  | awk '{print $1}')
    fdate=$(stat --printf=%y "$file" | awk '{print $1}')
    file_new="${file%%.*}"
    ext=${file##*.}
    echo "mv -v $file $file_new-$hash-$fdate.$ext"
    mv -v "$file" "$file_new-$hash-$fdate.$ext"
  fi
done

exit 0
