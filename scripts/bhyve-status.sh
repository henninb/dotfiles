#!/bin/sh

if [ "$OS" = "FreeBSD" ]; then
  echo git@github.com:michaeldexter/vmrc.git
  echo ls -al /dev/vmm
  sudo kldstat | grep vmm
  sudo vm list

  sudo vm start centos7
  sudo vm info centos7

  sudo kldstat | grep nmdm
  echo sudo vm console centos7
fi

exit 0

# vim: set ft=sh:
