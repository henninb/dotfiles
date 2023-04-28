#!/bin/sh

if ! command -v play; then
  sudo emerge --update --newuse sox
fi

if ! command -v rtl_test; then
  sudo emerge --update --newuse net-wireless/rtl-sdr
fi

rtl_fm -M wbfm -f 92.5M | play -r 32k -t raw -e s -b 16 -c 1 -V1 -
rtl_fm -M wbfm -f 100.3M | play -r 32k -t raw -e s -b 16 -c 1 -V1 -

exit 0
# vim: set ft=sh:
