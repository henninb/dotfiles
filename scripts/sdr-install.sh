#!/bin/sh

lsusb | grep 2838

echo gqrx

cat << EOF > "$HOME/tmp/20.rtlsdr.rules"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666", SYMLINK+="rtl_sdr"
EOF

sudo mv -v "$HOME/tmp/20.rtlsdr.rules" /etc/udev/rules.d/20.rtlsdr.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi

exit 0
