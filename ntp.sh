#!/bin/sh

sudo zypper install -y ntp

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

echo sudo date -s "27 DEC 2020 12:24:00"

exit 0
