#!/bin/sh

version=$1
if [ $# -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

unzip -oq "v${version}.zip"

serve

exit 0
