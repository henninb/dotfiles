#!/bin/sh

#find . -maxdepth 1 -type f -exec ls -ld "{}" \;
files=$(find . -maxdepth 1 -type f -name "*.sh")

for sfile in $files; do
  #echo $sfile
  if git ls-files --error-unmatch "$sfile" >/dev/null 2>&1; then
    if ! shellcheck "$sfile" >/dev/null 2>&1; then
      echo "$sfile"
    fi
  fi
done

