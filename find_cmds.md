# find commands

## find files print size and full path to the file; then sort the list
find . -type f -printf "%s\t%p\n" | sort -n

## 100k file size
find . -size +102400 -type f

## find 10k file size
find . -size +10240 -type f

## find files modified 3 days old or less
find . -type f -mtime -3 -exec ls -l {} \;

## fine files created 1 days old or less
find . -type f -ctime -1 -exec ls -l {} \;

## find dot directories
find . -type d -iname ".*" -ls

## find files with spaces
find . -type f -exec egrep -l " +$" {} \;

## find java src files and convert them from dos2unix
find . -type f -name "*.java" -exec dos2unix {} \;
