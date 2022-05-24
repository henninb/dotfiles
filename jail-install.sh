#!/bin/sh

if [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y ezjail
  sudo sysrc ezjail_enable="YES"
  sudo sysrc cloned_interfaces="bridge0 tap0 bridge1 tap1 bridge2 tap2 lo1"
fi

exit 0

# vim: set ft=sh
