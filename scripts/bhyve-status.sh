#!/bin/sh

if [ "$OS" = "FreeBSD" ]; then
  echo git@github.com:michaeldexter/vmrc.git
  echo ls -al /dev/vmm
  doas kldstat | grep vmm
  doas vm list

  doas vm start centos7
  doas vm info centos7

  doas kldstat | grep nmdm
  echo sudo vm console centos7
fi

exit 0

# vim: set ft=sh:
