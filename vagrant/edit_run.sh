#!/bin/sh

#find . -name run.sh | xargs -o vim
vim $(find . -name run.sh)

exit 0
