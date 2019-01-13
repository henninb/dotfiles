#!/bin/sh

echo $(date) >> /home/henninb/out
if [ "$OS" = "FreeBSD" ]; then
  sudo shutdown -p now
else
  sudo shutdown -h now
fi

exit 0
