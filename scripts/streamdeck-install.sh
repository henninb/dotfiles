#!/bin/sh

sudo emerge dev-libs/hidapi

cat << EOF > "$HOME/tmp/70-streamdeck.rules"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", TAG+="uaccess"
EOF

sudo mv -v "$HOME/tmp/70-streamdeck.rules" /etc/udev/rules.d/70-streamdeck.rules
sudo udevadm control --reload-rules

pip3 install --user streamdeck_ui

exit 0
