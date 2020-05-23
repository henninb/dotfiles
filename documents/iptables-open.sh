#!/bin/sh

INTERNET=enp0s7
LAN1=enp2s0f0
LAN2=enp2s0f1

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT

# Forward WAN packets to the LAN if the LAN initiated the connection.
sudo iptables -A FORWARD -i $INTERNET -o $LAN1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i $INTERNET -o $LAN2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# NAT traffic going out the WAN interface.
sudo iptables -t nat -A POSTROUTING -o $INTERNET -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE

sudo netfilter-persistent save
sudo netfilter-persistent reload

sudo iptables -S

exit 0
