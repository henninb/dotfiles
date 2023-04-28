#!/bin/sh


if ! command -v shellcheck; then
  curl -sSL https://get.haskellstack.org/ | sh
  stack update
  stack install ShellCheck
fi

# if [ ! -x "$(command -v shellcheck)" ]; then
#   echo "Please install shellcheck."
#   sudo apt install shellcheck
#   sudo pacman --noconfirm --needed -S shellcheck
#   exit 1
# fi

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

exit 0

# vim: set ft=sh:
