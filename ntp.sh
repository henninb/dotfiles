#!/bin/sh

if [ "$OS" = "FreeBSD" ]; then
  date
  sudo ntpdate -s time.nist.gov
  date
else
  date
  sudo ntpdate -s time.nist.gov
  sudo hwclock
  sudo hwclock -w
  date
fi

exit 0
