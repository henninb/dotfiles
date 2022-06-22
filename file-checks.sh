#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

if [ ! \( -e "${FILE}" \) ]; then
     echo "%ERROR: file ${FILE} does not exist!" >&2
     exit 1
elif [ ! \( -f "${FILE}" \) ]; then
     echo "%ERROR: ${FILE} is not a file!" >&2
     exit 2
elif [ ! \( -r "${FILE}" \) ]; then
     echo "%ERROR: file ${FILE} is not readable!" >&2
     exit 3
elif [ ! \( -s "${FILE}" \) ]; then
     echo "%ERROR: file ${FILE} is empty!" >&2
     exit 4
fi

exit 0

# vim: set ft=sh:

