#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

sudo dd if=/dev/sr0 of="$FILE"

exit 0

# vim: set ft=sh:
