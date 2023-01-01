#!/bin/sh

if command -v pacman; then
  date
  sudo ntpdate -s time.nist.gov
  date
  # sudo hwclock
  # sudo hwclock -w
elif command -v zypper; then
  # sudo zypper install -y ntp
  date
  sudo ntpdate -s time.nist.gov
  date
elif command -v dnf; then
  date
  sudo ntpdate -s time.nist.gov
  date
elif command -v emerge; then
  date
  sudo ntpdate -s time.nist.gov
  date
elif command -v pkg; then
  date
  sudo ntpdate -s time.nist.gov
  date
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
