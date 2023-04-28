#!/bin/sh

mkdir -p "$HOME/files/keepass-git"
cd "$HOME/files/keepass-git" || exit
git init .
git remote add origin pi:/home/pi/downloads/keepass-git
git fetch
git merge origin main

exit 0
# vim: set ft=sh:
