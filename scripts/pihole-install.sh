#!/bin/sh

if [ "$OS" = "Debian GNU/Linux" ]; then
  curl -sSL https://install.pi-hole.net | sudo bash

  echo set password
  pihole -a -p
fi

exit 0

# vim: set ft=sh:
