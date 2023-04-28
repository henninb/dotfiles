#!/bin/sh

#for pem in /etc/ssl/certs/*.pem; do
for file in *; do
  if [ -f "$file" ] && [ ! "$file" = "file-renamer.sh" ]; then
    hash=$(md5sum "$file"  | awk '{print $1}')
    fdate=$(stat --printf=%y "$file" | awk '{print $1}')
    file_new="${file%%.*}"
    ext=${file##*.}
    # echo "mv -v $file $file_new-$hash-$fdate.$ext"
    if [ ! -z "${file##*$hash*}" ] ;then
      mv -v "$file" "$file_new-$hash-$fdate.$ext"
    fi
  else
    echo "file skipped = $file"
  fi
done

exit 0
# vim: set ft=sh:
