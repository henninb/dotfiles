#!/bin/sh

# Font Awesome 5 Free
if [ "$(bluetoothctl show | grep 'Powered: yes' | wc -c)" -eq 0 ]; then
  #echo "%{F#66ffffff}"
  echo "%{F#66ffffff}B
else
  #if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]; then
  #  #echo ""
  #  echo "B
  #fi
  #echo "%{F#2193ff}"
  #echo "%{F#2193ff}B
  echo C
fi
