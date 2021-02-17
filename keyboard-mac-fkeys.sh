#!/bin/sh

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

if ! grep -q "hid_apple" < /etc/modprobe.d/hid_apple.conf; then
  echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
fi

sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:escape"/' /etc/default/keyboard

exit 0
