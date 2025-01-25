#!/bin/sh

doas emerge --update --newuse sys-auth/yubikey-personalization-gui
doas emerge --update --newuse sys-auth/pam_u2f

mkdir ~/.config/Yubico/

echo primary-key
pamu2fcfg > ~/.config/Yubico/u2f_keys
echo second-key
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
echo third-key
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
chmod 600 ~/.config/Yubico/u2f_keys

echo sudo vi /etc/pam.d/system-auth
echo top of the file
echo auth        sufficient                  pam_u2f.so      cue
# echo sudo systemctl edit getty@tty1
# echo /etc/systemd/system/getty@tty1.service.d/override.conf

exit 0
