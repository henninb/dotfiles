#!/bin/sh

echo lsusb

echo wifi passowrd
read -r wifi_password

cat > wpa_supplicant.conf <<EOF
network={
 ssid="ssid_name"
 psk="$wifi_password"
}
EOF

echo sudo modprobe -w
sudo modprobe | grep idProduct=c811
echo New USB device found, idVendor=0bda, idProduct=c811, bcdDevice= 2.00
echo yay -S rtl88xxau-aircrack-dkms-git

echo sudo usb_modeswitch -KW -v 0bda -p 1a2b
echo sudo usb_modeswitch -KW -v 0bda -p c811
# rtl88xxau-aircrack-dkms-git and rtl8821au-dkms-git
echo sudo dkms install rtl8821CU/5.4.1 -k $(uname -r)

cd "$HOME/projects" || exit
# git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
# git clone https://github.com/lwfinger/rtl8723bu.git
git clone https://github.com/brektrou/rtl8821CU.git
cd rtl8723bu || exit
make
sudo make install
sudo modprobe 8812au

#nmcli
ccccudvkjugrgdcdh
echo nmcli d wifi list

echo nmtui
exit 0

# NetworkManager-tui

ip link show | grep w

sudo iwconfig wlp0s20u7 essid NSA_classified key s:password

sudo eopkg install -y wpa_supplicant

wpa_passphrase NSA_classified passphrase | sudo tee /etc/wpa_supplicant.conf
dhclient interface

sudo wpa_supplicant -B -i wlp0s20u7 -c /etc/wpa_supplicant.conf
sudo wpa_supplicant -B -i wlp7s0 -c /etc/wpa_supplicant.conf
sudo wpa_supplicant -B -i wlp2s0f0u8u3 -c /etc/wpa_supplicant.conf

sudo ip link set wlp0s20u7 up
sudo ip link set wlp7s0 up
sudo ip link set wlp2s0f0u8u3 up

sudo nmcli -a device wifi connect NSA_classified
nmcli d wifi list --rescan yes

exit 0

nmcli nm wifi on
nmcli nm wifi off
on newer version:

nmcli radio wifi on
nmcli radio wifi off

# vim: set ft=sh:
