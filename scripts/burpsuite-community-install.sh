#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  echo mintlinux
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo archlinux
elif [ "$OS" = "Solus" ]; then
  echo solus
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  doas eselect repository enable pentoo
  doas emaint sync -r pentoo
  sudo emerge --update --newuse net-proxy/burpsuite
elif [ "$OS" = "Void" ]; then
  echo void
elif [ "$OS" = "fedora" ]; then
  echo fedora
else
  echo "$OS is not yet implemented."
fi

exit 0

# vim: set ft=sh:
