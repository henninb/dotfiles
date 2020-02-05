#!/bin/sh

echo "hello" > $HOME/file.txt
cp $HOME/file.txt{,.bak}

exit 0
