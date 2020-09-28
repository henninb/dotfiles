#!/bin/sh

curl -sSL https://get.haskellstack.org/ | sh
stack update

cd "$HOME/projects" || exit
#git clone https://github.com/koalaman/shellcheck.git
git clone git@github.com:koalaman/shellcheck.git
cd shellcheck || exit
stack build
stack install

exit 0
