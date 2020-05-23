#!/bin/sh

# /etc/rc.local

# https://www.ascinc.com/blog/linux/how-to-build-a-simple-router-with-ubuntu-server-18-04-1-lts-bionic-beaver/

# apply persistent iptable rules
# sudo apt-get install -y iptables-persistent
# sudo dpkg-reconfigure iptables-persistent

INTERNET=enp0s7
LAN1=enp2s0f0
LAN2=enp2s0f1

sudo systemctl mask systemd-networkd-wait-online.service
# Default policy to drop all incoming packets.
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

# Accept incoming packets from localhost and the LAN interface.
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -i $LAN1 -j ACCEPT
sudo iptables -A INPUT -i $LAN2 -j ACCEPT

# Accept incoming packets from the WAN if the router initiated the connection.
sudo iptables -A INPUT -i $INTERNET -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Forward LAN packets to the WAN.
sudo iptables -A FORWARD -i $LAN1 -o $INTERNET -j ACCEPT
sudo iptables -A FORWARD -i $LAN2 -o $INTERNET -j ACCEPT

# Forward WAN packets to the LAN if the LAN initiated the connection.
sudo iptables -A FORWARD -i $INTERNET -o $LAN1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i $INTERNET -o $LAN2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# NAT traffic going out the WAN interface.
sudo iptables -t nat -A POSTROUTING -o $INTERNET -j MASQUERADE

# drop connections between the local LAN networks
# sudo iptables -A FORWARD -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
# sudo iptables -A FORWARD -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP
# sudo iptables -A INPUT -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
# sudo iptables -A INPUT -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP
# sudo iptables -A OUTPUT -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
# sudo iptables -A OUTPUT -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP

# drop facebook outgoing requests
# sudo iptables -A OUTPUT -p tcp -d www.facebook.com -j DROP
# sudo iptables -A OUTPUT -p tcp -d facebook.com -j DROP

sudo iptables -t nat -L -n -v
sudo iptables -S

# rc.local needs to exit with 0
exit 0
