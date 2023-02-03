#!/bin/sh

sudo emerge libyubikey
sudo emerge app-crypt/yubikey-manager
echo ykman

git clone https://github.com/Yubico/yubico-c-client.git
cd yubico-c-client
autoreconf --install

exit 1
git clone https://github.com/Yubico/yubico-pam.git
cd yubico-pam
autoreconf --install
./configure

make check install

exit 0
