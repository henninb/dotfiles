#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi
FILE=$1
#git log --follow -- vscode_cmds.md
#git log --follow -- jq.txt
git log --follow -- "$FILE"

exit 0

# vim: set ft=sh:

