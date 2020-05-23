#!/bin/sh

INTERNET=enp2s0
LAN1=enp1s0f0
LAN2=enp1s0f1

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X

sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P INPUT DROP

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -i $LAN1 -j ACCEPT
sudo iptables -A INPUT -i $LAN2 -j ACCEPT


sudo iptables -A FORWARD -i ppp0 -o $LAN1 -j DROP
sudo iptables -A FORWARD -i ppp0 -o $LAN2 -j DROP
sudo iptables -A FORWARD -i $INTERNET -o $LAN1 -j DROP
sudo iptables -A FORWARD -i $INTERNET -o $LAN2 -j DROP
#sudo iptables -A FORWARD -s 192.168.2.0/24 -d 192.168.1.0/24 -j DROP

# Forward WAN packets to the LAN if the LAN initiated the connection.
sudo iptables -A FORWARD -i $INTERNET -o $LAN1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i $INTERNET -o $LAN2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ppp0 -o $LAN1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ppp0 -o $LAN2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#sudo dpkg-reconfigure iptables-persistent

# NAT traffic going out the WAN interface.
sudo iptables -t nat -A POSTROUTING -o $INTERNET -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE

# drop connections between the local LAN networks
sudo iptables -A FORWARD -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
sudo iptables -A FORWARD -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP
sudo iptables -A INPUT -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
sudo iptables -A INPUT -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP
sudo iptables -A OUTPUT -s 192.168.20.0/24 -d 192.168.10.0/24 -j DROP
sudo iptables -A OUTPUT -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP



#sudo netfilter-persistent save
#sudo netfilter-persistent reload

sudo iptables -S

exit 0

