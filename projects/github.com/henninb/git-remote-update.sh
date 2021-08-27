#!/bin/sh

repos=$(find . -mindepth 1 -maxdepth 1 -type d -printf '%P\n')

for i in $repos; do
  cd "$i" || exit
  git remote -v
  git remote remove origin && git remote add origin git@github.com:henninb/$i.git
  git remote -v
  cd - || exit
  # git_remap
done

