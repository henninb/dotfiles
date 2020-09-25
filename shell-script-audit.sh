#!/bin/sh

sudo apt install shellcheck
#find . -maxdepth 1 -type f -exec ls -ld "{}" \;
files=$(find . -maxdepth 1 -type f -name "*.sh")

for sfile in $files; do
  #echo $sfile
  if git ls-files --error-unmatch "$sfile" >/dev/null 2>&1; then
    if ! shellcheck "$sfile" >/dev/null 2>&1; then
      # count=$(shellcheck "$sfile" | grep -c SC)
      # if [ "$count" -lt 6 ]; then
        echo "$sfile"
      # fi
    fi
  fi
done

