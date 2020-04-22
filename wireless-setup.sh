£!/bin/sh

lsusb


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

ip link sho | grep w

sudo iwlist scan
iwconfig wlp0s20u7 essid NSA_classified key s:<password>

sudo eopkg install -y wpa_supplicant
cat > wpa_supplicant.conf <<EOF
network={
 ssid="ssid_name"
 psk="password"
}
EOF
wpa_passphrase MYSSID passphrase > /etc/wpa_supplicant.conf
dhclient interface

sudo wpa_supplicant -B -i wlp0s20u7 -c /etc/wpa_supplicant.conf

sudo ifconfig wlp0s20u7 up
sudo ip link set wlp0s20u7 up

sudo nmcli d wifi connect '' password ''
nmcli -a d wifi connect '' 
nmcli d wifi list --rescan yes

exit 0

Bus 002 Device 007: ID 0bda:c811 Realtek Semiconductor Corp.
Couldn't open device, some information will be missing
nmcli nm wifi on
nmcli nm wifi off
on newer version:

nmcli radio wifi on
nmcli radio wifi off

