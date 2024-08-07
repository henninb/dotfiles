#!/bin/sh

lsusb | grep 2838

if ! command -v gqrx; then
  doas emerge --update --newuse gqrx
fi

if ! command -v rtl_test; then
  sudo emerge --update --newuse net-wireless/rtl-sdr
fi

if ! command -v play; then
  doas emerge --update --newuse sox
fi

echo net-wireless/cubicsdr

cat << EOF > "$HOME/tmp/80-rtlsdr.rules"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666", SYMLINK+="rtl_sdr"
EOF

# echo "blacklist rtl2832" | sudo tee -a /etc/modprobe.d/blacklist.conf

sudo mv -v "$HOME/tmp/80-rtlsdr.rules" /etc/udev/rules.d/80-rtlsdr.rules
sudo chown root:root /etc/udev/rules.d/80-rtlsdr.rules
if command -v udevadm; then
  doas udevadm control --reload-rules
  # sudo udevadm control --reload
  doas udevadm trigger
fi

doas groupadd sdr
doas usermod -aG sdr henninb
rtl_test -t

echo sudo systemctl status systemd-udevd

exit 0
# vim: set ft=sh:
