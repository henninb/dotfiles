#!/bin/sh

wget 'https://download.eclipse.org/jdtls/milestones/1.6.0/jdt-language-server-1.6.0-202111261512.tar.gz'
mkdir -p "$HOME/projects/jdtls"
cd "$HOME/projects/jdtls" || exit
tar xvf "$HOME/jdt-language-server-*.tar.gz"

exit 0

# vim: set ft=sh:
