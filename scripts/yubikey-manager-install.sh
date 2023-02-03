#!/bin/sh

cat <<  EOF > "$HOME/tmp/70-u2f.rules"
#ACTION!="add|change", GOTO="fido_end"

# YubiKey 4 OTP+FIDO+CCID by Yubico AB
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", TAG+="uaccess", GROUP="plugdev", MODE="0660"
# SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", TAG+="uaccess", GROUP="plugdev", MODE="0660"
# ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess", GROUP="plugdev", MODE="0660"

#LABEL="fido_end"
EOF

sudo mv -v "$HOME/tmp/70-u2f.rules" /etc/udev/rules.d/70-u2f.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi
systemctl status systemd-udevd

sudo chown root:root /etc/udev/rules.d/70-u2f.rules

exit 1

sudo emerge --update --newuse libyubikey
sudo emerge --update --newuse app-crypt/yubikey-manager
sudo emerge --update --newuse yubikey-manager-qt
sudo emerge --update --newuse app-crypt/libu2f-server
sudo emerge --update --newuse app-crypt/libu2f-host
sudo emerge --update --newuse sys-auth/pam_u2f
sudo usermod -a -G plugdev "$(whoami)"
sudo emerge --update --newuse sys-fs/mtpfs

sudo emerge --update --newuse sys-apps/pcsc-lite
sudo systemctl status pcscd
sudo systemctl enable pcscd
sudo systemctl start pcscd
# pamu2fcfg -uuser > ~/.config/Yubico/u2f_keys
gpg --card-status

echo ykman info
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
