#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1

echo sudo dd if=${FILE} of=/dev/sdc bs=4M && sync

exit 0
