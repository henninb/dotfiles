#!/bin/sh
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables --policy INPUT ACCEPT
sudo iptables --policy OUTPUT ACCEPT
sudo iptables --policy FORWARD ACCEPT
sudo iptables -Z
sudo iptables -F
sudo iptables -X
sudo iptables -A INPUT -i docker0 -j ACCEPT
#sudo iptables FORWARD -i docker0 -o enp3s0 -j ACCEPT
#sudo iptables FORWARD -i enp3s0 -o docker0 -j ACCEPT
sudo systemctl restart docker
exit 0
