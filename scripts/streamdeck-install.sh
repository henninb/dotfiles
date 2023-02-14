#!/bin/sh

if command -v emerge; then
  sudo emerge --update --newuse dev-libs/hidapi
fi


if command -v dnf; then
  sudo dnf install -y libusb1-devel
  sudo dnf install -y libgudev-devel
  sudo dnf install -y hidapi-devel
  sudo dnf install -y libudev-devel
  sudo dnf install -y freetype-devel
  sudo dnf install -y hidapi-devel
  sudo dnf install -y libhid-devel
  sudo dnf install -y libjpeg-devel
  sudo dnf install -y libpng-devel
  sudo dnf install -y libxc-devel
  sudo dnf install -y systemd-devel
  sudo dnf install -y zlib-devel
fi

# sudo xbps-install -y elogind
sudo xbps-install -y hidapi-devel

# sudo ln -s /etc/sv/elogind /etc/runit/runsvdir/current/
sudo xbps-install -y libgusb-devel
sudo xbps-install -y python3-devel

cat << EOF > "$HOME/tmp/99-streamdeck.rules"
# SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", TAG+="uaccess"
# SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", TAG+="uaccess"
# SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", TAG+="uaccess"
# SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", TAG+="uaccess"

SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", TAG+="uaccess",MODE="0660",GROUP="plugdev"
EOF

sudo mkdir -p /etc/udev/rules.d/
sudo mv -v "$HOME/tmp/99-streamdeck.rules" /etc/udev/rules.d/99-streamdeck.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi
sudo chown root:root /etc/udev/rules.d/99-streamdeck.rules

if ! command -v pip3; then
   pip install --user streamdeck_ui
   echo "pip3 needs to be installed"
   exit 1
fi

if ! pip3 install --user streamdeck_ui; then
 echo "install failed"
fi

exit 0
