#!/bin/sh

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  apt list --installed > os_mint.txt
else
  echo $OS is not yet implemented.
  exit 1
fi

echo sudo pacman -R xmonad

exit 0

