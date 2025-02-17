#!/bin/sh

doas emerge --update --newuse  net-vpn/mullvadvpn-app
yay -S  mullvad-vpn-bin
sudo systemctl enable mullvad-daemon
sudo systemctl start mullvad-daemon
systemctl status mullvad-daemon

echo added to hyprland
echo mullvad-vpn

mullvad account list-devices
mullvad account -h
mullvad account login
echo mullvad disconnect
echo mullvad connect
mullvad status
mullvad --help

exit 0
