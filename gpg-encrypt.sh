#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

gpg -r 'henninb@gmail.com' -e $FILE

exit 0

# for ELEMENT in $(ls -1 file); do
#   echo $ELEMENT
#   gpg --batch --yes --recipient henninb@gmail.com --encrypt $ELEMENT
#   git add -f $ELEMENT.gpg
# done
