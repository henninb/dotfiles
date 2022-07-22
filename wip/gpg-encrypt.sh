#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

gpg -r 'henninb@gmail.com' -e "$FILE"

exit 0

# vim: set ft=sh:
