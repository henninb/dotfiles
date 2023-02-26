#!/bin/sh

if [ "$OS" = "FreeBSD" ]; then
  pkgs="trayer volumeicon feh xscreensaver numlockx blueman-applet copyq picom dunst flameshot nm conky keepassxc"
else
  pkgs="trayer volumeicon feh xscreensaver numlockx blueman-applet copyq picom dunst flameshot nm-applet conky keepassxc"
fi

for i in $pkgs; do
  if [ ! -x "$(command -v "$i")" ]; then
    FAILURE="$i $FAILURE"
  fi
  if ! pgrep "$i"; then
    if [ "$i" != "feh" ] && [ "$i" != "numlockx" ]; then
      echo "not running $i"
    fi
  fi
done

echo "not installed: $FAILURE"

# nohup volumeicon &
# nohup trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 108 --transparent true --tint 0x000000 --height 18 --alpha 0 &
# nohup picom --experimental-backends --backend glx --xrender-sync-fence &

exit 0

# vim: set ft=sh
