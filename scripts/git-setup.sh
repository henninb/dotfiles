#!/bin/sh

git config --global --list
git config --global core.pager less
# git config --list
# git config --global core.pager 'nvim -'
# git config --global diff.tool meld
git difftool --tool-help
git config --global diff.tool nvimdiff

exit 0

# vim: set ft=sh
