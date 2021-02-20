#!/bin/sh

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

if [ ! -f "/etc/modprobe.d/hid_apple.conf" ]; then
  sudo touch /etc/modprobe.d/hid_apple.conf
fi

if ! grep -q "hid_apple" < /etc/modprobe.d/hid_apple.conf; then
  echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
fi

if [ ! -f "/etc/default/keyboard" ]; then
  echo 'XKBOPTIONS=""' | sudo tee -a /etc/default/keyboard
fi

sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:escape"/' /etc/default/keyboard

echo keyboard
cat /etc/default/keyboard

echo hid_apple.conf
cat /etc/modprobe.d/hid_apple.conf

exit 0
