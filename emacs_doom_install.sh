#!/bin/sh

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom refresh


cd projects
git clone git@github.com:emacs-mirror/emacs.git
cd emacs


exit 0
