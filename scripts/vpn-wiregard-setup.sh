#!/bin/sh

echo raspberrypi

sudo apt install wireguard

## as root
umask 077
wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key

Edit /etc/sysctl.conf, ensure:
net.ipv4.ip_forward=1

cat > "$HOME/tmp/wg0.conf" << EOF
[Interface]
Address = 10.200.200.1/24
ListenPort = 51820
PrivateKey = sBj5CNLLGiNfYN0T8yuE9a4iZe1Q8LcLGE+ybgxBBW0=

PostUp = sysctl -w net.ipv4.ip_forward=1 net.ipv4.conf.all.rp_filter=0 net.ipv4.conf.wlan0.rp_filter=0 && iptables -A FORWARD -i wg0  -o wlan0 -j ACCEPT && iptables -A FORWARD -i wlan0 -o wg0  -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT && iptables -t nat -A POSTROUTING -s 10.200.200.0/24 -o wlan0 -j MASQUERADE

PostDown = sysctl -w net.ipv4.ip_forward=0 && iptables -D FORWARD -i wg0  -o wlan0 -j ACCEPT && iptables -D FORWARD -i wlan0 -o wg0  -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT && iptables -t nat -D POSTROUTING -s 10.200.200.0/24 -o wlan0 -j MASQUERADE


# gentoo workstation
[Peer]
PublicKey  = N9MHtjlFZX0WH649aKpwci8Um8QI3+VqctI5Ti6dmgA=
AllowedIPs = 10.200.200.2/32

# archlinux laptop
[Peer]
PublicKey  = SfAJ81/5Sm5qTFqG3S2HdNKtbAZhqi7xx4eYRTqdAQA=
AllowedIPs = 10.200.200.3/32

# pixel phone
[Peer]
PublicKey  = p1F4/E5s+CDdComD6ZFPZsjuicgEIWpOahBt3Dal8Eg=
AllowedIPs = 10.200.200.4/32
EOF

sudo mv "$HOME/tmp/wg0.conf" /etc/wireguard/

sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
sudo dhclient wlan0

sudo wg-quick up wg0
sudo wg-quick down wg0
sudo wg show wg0


sudo wg-quick up gentoo
sudo wg show gentoo

# gentoo
umask 077
wg genkey | tee /etc/wireguard/client_private.key | wg pubkey > /etc/wireguard/client_public.key

emerge net-vpn/wireguard-tools


sudo systemctl enable wg-quick@gentoo

gentoo /etc/wireguard > ls
client_private.key  client_public.key  gentoo.conf

silverfox /etc/wireguard > cat gentoo.conf
cat > "$HOME/tmp/gentoo.conf" << EOF
[Interface]
PrivateKey = eEh358hMmhIFJl9fKxR0qgw9FoszhipTHporPQNxXVI=
Address = 10.200.200.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = kI+DNJ9qPsCgILWOmDbfuTWDb4zAYHDAJ+DY5UuAnDo=
Endpoint = 10.0.0.175:51820
AllowedIPs = 10.200.200.1/32, 192.168.4.0/22
PersistentKeepalive = 25
EOF

exit 0
