#!/bin/sh

echo disable wifi
sudo ip link set wlp4s0 down

echo clearn slate
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X


echo set default policy
sudo iptables -P INPUT   DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT  ACCEPT

echo allow loopback and established traffic
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

sudo Drop packets the conntrack thinks are invalid
sudo iptables -I INPUT 1 -m conntrack --ctstate INVALID      -j DROP

echo enp3s0 reject spoofed addresses
sudo iptables -I INPUT 2 -i enp3s0 -s 127.0.0.0/8            -j DROP
sudo iptables -I INPUT 2 -i enp3s0 -s 224.0.0.0/4            -j DROP
sudo iptables -I INPUT 2 -i enp3s0 -s 240.0.0.0/5            -j DROP


# NULL scan (no flags)
sudo iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
# XMAS scan (FIN+PSH+URG)
sudo iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
# SYN floods: allow only a few
sudo iptables -N SYN_FLOOD
sudo iptables -A INPUT -p tcp --syn -m limit --limit 3/s --limit-burst 4 -j RETURN
sudo iptables -A INPUT -p tcp --syn -j DROP
sudo iptables -A INPUT -j SYN_FLOOD

echo do I want to allow ping
echo sudo iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

echo address bypass your default DROP with DOCKER
# sudo iptables -I DOCKER-USER -j DROP

# 1) Create the chain
sudo iptables -t filter -N DOCKER-USER

# 2) Ensure Docker jumps into it from FORWARD
sudo iptables -t filter -I FORWARD 1 -j DOCKER-USER

# 3) Insert your bypass rule (replace <ADDRESS>):
sudo iptables -t filter -I DOCKER-USER 1 -s 192.168.10.0/24 -j ACCEPT

# 4) Then drop all other traffic:
sudo iptables -t filter -A DOCKER-USER -j DROP

exit 0
