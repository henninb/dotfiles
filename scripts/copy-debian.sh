#!/bin/sh

ssh hornsup mkdir -p /home/henninb/docker/
rsync -arvz "$HOME/.ssh/" "hornsup:/home/henninb/.ssh/"
rsync -arvz "$HOME/scripts/" "hornsup:/home/henninb/scripts/"
rsync -arvz "$HOME/.profile" "hornsup:/home/henninb/.portfolio"
rsync -arvz --include=".zsh*" --exclude '*' "$HOME/" "hornsup:/home/henninb/"
rsync -arvz --include=".alias*" --exclude '*' "$HOME/" "hornsup:/home/henninb/"
rsync -arvz "$HOME/.gitignore" "hornsup:/home/henninb/"
rsync -arvz "$HOME/.gitconfig" "hornsup:/home/henninb/"
rsync -arvz "$HOME/ssl/" "hornsup:/home/henninb/ssl/"
rsync -arvz "$HOME/.local/fonts/" "hornsup:/home/henninb/.local/fonts/"
# rsync -arvz --exclude='.git' --exclude='*.crt' --exclude='*.key' "$HOME/docker/nginx-reverse-proxy-subdomains/" "hornsup:/home/henninb/docker/nginx-reverse-proxy-subdomains/"

rsync -arvz "$HOME/.irssi/" "hornsup:/home/henninb/.irssi/"
rsync -arvz --exclude='audio' --exclude='apikey' "$HOME/src/api/youtube/" "hornsup:/home/henninb/src/api/youtube/"

exit 0

# vim: set ft=sh:
