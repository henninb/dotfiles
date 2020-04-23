£!/bin/sh

lsusb

git clone https://github.com/brektrou/rtl8821CU.git
git clone https://github.com/lwfinger/rtl8723bu.git
cd rtl8723bu
nano Makefile
make
sudo make install
sudo modprobe -v 8723bu

nmcli
nmcli dev status

nmcli d wifi list

nmtui

NetworkManager-tui

ip link show | grep w

sudo iwlist scan
sudo iwconfig wlp0s20u7 essid NSA_classified key s:password

sudo eopkg install -y wpa_supplicant
cat > wpa_supplicant.conf <<EOF
network={
 ssid="ssid_name"
 psk="password"
}
EOF

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

Bus 002 Device 007: ID 0bda:c811 Realtek Semiconductor Corp.
nmcli nm wifi on
nmcli nm wifi off
on newer version:

nmcli radio wifi on
nmcli radio wifi off

