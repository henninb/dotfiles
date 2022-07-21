#!/bin/sh

cd projects || exit
git clone git@github.com:ryanoasis/nerd-fonts.git

cd - || exit
exit 0

# vim: set ft=sh
