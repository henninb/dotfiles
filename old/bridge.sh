sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT


sudo iptables -t nat -P PREROUTING ACCEPT
sudo iptables -t nat -P POSTROUTING ACCEPT
sudo iptables -t nat -P OUTPUT ACCEPT

sudo iptables -t mangle -P PREROUTING ACCEPT
sudo iptables -t mangle -P OUTPUT ACCEPT

sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F

sudo iptables -X
sudo iptables -t nat -X
sudo iptables -t mangle -X

#sudo iptables -P INPUT ACCEPT
#sudo iptables -P FORWARD ACCEPT
#sudo iptables -P OUTPUT ACCEPT
sudo ip link add name br0 type bridge
sudo ip link set dev br0 up
sudo ip link set enp9s0 up
sudo ip link set enp9s0 master br0
