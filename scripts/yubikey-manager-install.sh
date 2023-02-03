#!/bin/sh

cat <<  EOF > "$HOME/tmp/10-security-key.rules"
KERNEL="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="users", ATTRS{idVendor}=="2581", ATTRS{idProduct}="f1d0"
EOF

sudo mv -v "$HOME/tmp/10-security-key.rules" /etc/udev/rules.d/10-security-key.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi
sudo chown root:root /etc/udev/rules.d/10-security-key.rules

exit 1
sudo emerge --update --newuse libyubikey
sudo emerge --update --newuse app-crypt/yubikey-manager
sudo emerge --update --newuse yubikey-manager-qt
echo ykman
echo ykman-gui
ykman list --serials
ykman --device 1234 info

exit 1

git clone https://github.com/Yubico/yubico-c-client.git
cd yubico-c-client
autoreconf --install

git clone https://github.com/Yubico/yubico-pam.git
cd yubico-pam
autoreconf --install
./configure

make check install

exit 0
