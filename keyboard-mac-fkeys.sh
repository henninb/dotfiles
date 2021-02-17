#!/bin/sh

echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode

sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:escape"/' /etc/default/keyboard

exit 0
