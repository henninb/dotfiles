#!/bin/sh

#find . -name run.sh | xargs -o vim
vim $(find . -name Vagrantfile)

exit 0
