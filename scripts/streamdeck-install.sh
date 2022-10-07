#!/bin/sh

if command -v emerge; then
  sudo emerge --update --newuse dev-libs/hidapi
fi

cat << EOF > "$HOME/tmp/70-streamdeck.rules"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", TAG+="uaccess"
EOF

sudo mv -v "$HOME/tmp/70-streamdeck.rules" /etc/udev/rules.d/70-streamdeck.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi

if ! command -v pip3; then
   pip install --user streamdeck_ui
   echo "pip3 needs to be installed"
   exit 1
fi

if ! pip3 install --user streamdeck_ui; then
 echo "install failed"
fi

exit 0
