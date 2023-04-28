#!/bin/sh

cd .config || exit

# list=$(git ls-tree -r main --name-only | grep '/' | awk -F "/" '{print $1}' | sort | uniq)
list=$(git ls-files . --ignored --exclude-standard --others | grep '/' | awk -F "/" '{print $1}' | sort | uniq)

for elem in $list; do
  echo $elem
  touch "$elem/.save"
  git add -f "$elem/.save"
done



exit 0
# vim: set ft=sh:
