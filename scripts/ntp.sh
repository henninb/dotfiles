#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
  # sudo hwclock
  # sudo hwclock -w
elif [ "$OS" = "Gentoo" ]; then
  date
  # sudo ntpdate -s time.nist.gov
  sudo ntpdate -u pool.ntp.org
  date
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Void" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
elif [ "$OS" = "FreeBSD" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Fedora Linux" ]; then
  date
  sudo ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
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
