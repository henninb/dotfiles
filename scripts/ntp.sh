#!/bin/sh

if command -v pacman; then
  sudo ntpdate -s time.nist.gov
  sudo hwclock
  sudo hwclock -w
elif command -v zypper; then
  # sudo zypper install -y ntp
  sudo ntpdate -s time.nist.gov
elif command -v dnf; then
  date
  sudo ntpdate -s time.nist.gov
elif command -v emerge; then
  sudo ntpdate -s time.nist.gov
elif command -v pkg; then
  date
  sudo ntpdate -s time.nist.gov
  date
elif command -v emerge; then
  sudo emerge --update --newuse net-misc/ntp
  sudo ntpdate -s time.nist.gov
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo timedatectl set-ntp true
echo timedatectl status
echo timedatectl show-timesync --all

echo example:
echo "sudo date -s '27 DEC 2021 12:24:00'"

exit 0

# vim: set ft=sh
