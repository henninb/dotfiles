#!/bin/sh

pkgs="trayer volumeicon feh xscreensaver numlockx blueman-applet copyq picom dunst flameshot nm-applet conky"

for i in $pkgs; do
  if [ ! -x "$(command -v $i)" ]; then
    FAILURE="$i $FAILURE"
  fi
  if ! pgrep $i; then
    if [ "$i" != "feh" ] && [ "$i" != "numlockx" ]; then
      echo not running $i
    fi
  fi
done

  echo "not installed: $FAILURE"

exit 0
nohup volumeicon &
nohup trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 108 --transparent true --tint 0x000000 --height 18 --alpha 0 &
nohup picom --experimental-backends --backend glx --xrender-sync-fence &
# echo which trayer
# which trayer
# echo which volumeicon
# which volumeicon
# echo which feh
# which feh
# echo which xscreensaver
# which xscreensaver
# echo which numlockx
# which numlockx
# echo which blueman-applet
# which blueman-applet
# echo which copyq
# which copyq
# echo which picom
# which picom
# echo which dunst
# which dunst
# echo which flameshot
# which flameshot
# echo which nm-applet
# which nm-applet
# echo which conky
# which conky

exit 0
