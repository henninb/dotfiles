#!/bin/sh

curl -s "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.2-stable.tar.xz" -o "$HOME/tmp/flutter_linux_3.13.2-stable.tar.xz"
cd "$HOME/tmp/" || exit
doas tar -xvf flutter_linux_3.13.2-stable.tar.xz -C /opt

exit 0

# vim: set ft=sh:
