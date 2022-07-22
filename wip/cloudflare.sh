#!/bin/sh

mkdir -p "$HOME/projects/github.com/tech-otaku/"
cd "$HOME/projects/github.com/tech-otaku/" || exit
git clone git@github.com:tech-otaku/cloudflare-dns.git
cd cloudflare-dns || exit

exit 0

# vim: set ft=sh:
