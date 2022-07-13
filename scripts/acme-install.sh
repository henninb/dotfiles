#!/bin/sh

mkdir -p "$HOME/projects/github.com/acmesh-official"
cd "$HOME/projects/github.com/acmesh-official" || exit
git clone https://github.com/acmesh-official/acme.sh.git
cd acme.sh || exit
./acme.sh --install --force

# vim: set ft=sh
