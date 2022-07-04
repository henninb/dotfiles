#!/bin/sh

if [ -x "$(command -v zypper)" ]; then
  sudo zypper install -y ntp
fi
if [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse net-misc/ntp
fi

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

echo example:
echo sudo date -s "27 DEC 2021 12:24:00"

exit 0

# vim: set ft=sh
