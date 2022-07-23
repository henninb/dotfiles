#!/bin/sh

rsync -arvz "$HOME/.ssh/" "openbsd:/home/henninb/.ssh/"
rsync -arvz "$HOME/scripts/" "openbsd:/home/henninb/scripts/"
rsync -arvz "$HOME/.profile" "openbsd:/home/henninb/.portfolio"
rsync -arvz --include=".zsh*" --exclude '*' "$HOME/" "openbsd:/home/henninb/"
rsync -arvz --include=".alias*" --exclude '*' "$HOME/" "openbsd:/home/henninb/"
rsync -arvz "$HOME/.gitignore" "openbsd:/home/henninb/"
rsync -arvz "$HOME/.gitconfig" "openbsd:/home/henninb/"
rsync -arvz "$HOME/ssl/" "openbsd:/home/henninb/ssl/"
rsync -arvz "$HOME/.local/fonts/" "openbsd:/home/henninb/.local/fonts/"

exit 0

# vim: set ft=sh:
