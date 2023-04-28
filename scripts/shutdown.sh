#!/bin/sh

/usr/bin/date >> /home/henninb/crontab.log
if [ "$OS" = "FreeBSD" ]; then
  /usr/bin/sudo /usr/bin/shutdown -p now
else
  /usr/bin/sudo /usr/bin/shutdown -h now
fi

exit 0

# vim: set ft=sh:
