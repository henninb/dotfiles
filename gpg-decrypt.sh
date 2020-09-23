#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

FILE=$1
BASENAME=$(basename "${FILE}" .gpg)

gpg -d "$FILE" | tee "${BASENAME}"

exit 0
