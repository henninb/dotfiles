#!/bin/sh

sudo emerge --update --newuse libyubikey
sudo emerge --update --newuse app-crypt/yubikey-manager
sudo emerge --update --newuse yubikey-manager-qt
echo ykman
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
