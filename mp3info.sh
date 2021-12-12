#!/bin/sh

for f in $(find . -type f -name "*.mp3" -print); do
  # mp3info -a artist -t song file.mp3
  echo  $f
  echo $f | awk '{split($0,a, "-"); print a[0]; a[1]}'
  # echo $f | awk '{split($0,a, "-"); print a[1];}'
done

# find . -type f -name '*.mp3' -exec sh -c '
#   for file do
#     echo "$file"
#   done
# ' exec-sh {} +

# find . -name "*.mp3" -print0 | while IFS= read -r -d '' file; do
#     echo "file = $file"
# done

exit 0
