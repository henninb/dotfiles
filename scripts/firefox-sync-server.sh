#!/bin/sh

mkdir -p "$HOME/projects/github.com/crazy-max"
cd "$HOME/projects/github.com/crazy-max" || exit
git clone https://github.com/crazy-max/docker-firefox-syncserver
cd docker-firefox-syncserver || exit
docker buildx bake

exit 0
# vim: set ft=sh:
