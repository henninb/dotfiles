#!/bin/sh

cd $HOME/projects || exit
git clone https://github.com/koalaman/shellcheck.git
cd shellcheck || exit
stack build
stack install

exit 0
