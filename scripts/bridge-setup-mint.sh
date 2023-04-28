#!/bin/sh

sudo apt install -y libxml2-utils
sudo lshw -xml | tee hardware.xml
#xmllint --xpath "string(//list/node[@id="silverfox"])" hardware.xml
#xmllint --xpath "string(//list/node)" hardware.xml
#xmllint --xpath "string(//list/node/node/@id)" hardware.xml
SERIAL=$(xmllint --xpath "string(//list/node/node/serial)" hardware.xml)
echo "$SERIAL"

exit 1

cat > interfaces <<'EOF'
auto lo
iface lo inet loopback
# bridge setup DHCP enp0s31f6 - mintlinux
auto br0
 iface br0 inet dhcp
#    bridge_ports enp0s31f6
    bridge_ports wlp2s0
EOF

cat > sysctl.conf <<'EOF'
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
EOF

if [ "$OS" = "Linux Mint" ]; then
  echo 0 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables
  sudo apt install -y iptables-persistent
  sudo apt install -y resolvconf
  sudo rm /etc/resolv.conf
  sudo dpkg-reconfigure resolvconf

  sudo mv -v interfaces /etc/network/interfaces
  sudo mv -v sysctl.conf /etc/sysctl.conf
  exit 0
  echo "sysctl -p /etc/sysctl.conf" | sudo tee -a /etc/rc.local
  #sudo ip link add name br0 type bridge
  #sudo ip link set br0 up
  #sudo dhclient br0
elif [ "$OS" = "Arch Linux" ]; then
  echo 0 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables
  sudo ip link add name br0 type bridge
  sudo ip link set br0 up
  sudo ip link set enp9s0 master br0
  sudo bridge link
#  sudo dhclient br0
elif [ "$OS" = "Ubuntu" ]; then
  echo 0 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables
  sudo apt install -y iptables-persistent
  sudo apt install -y resolvconf
  sudo rm /etc/resolv.conf
  sudo dpkg-reconfigure resolvconf

  sudo ip link add name br0 type bridge
  sudo ip link set br0 up
  #sudo dhclient br0
else
  echo "$OS is not yet implemented."
  exit 1
fi
exit 0

#ip link set eth0 up
sudo ip link set eth0 master br0

sudo dhclient br0
sudo ip addr add dev br0 192.168.10.6/24

# delete bridge
sudo ip link delete br0 type bridge

#restart networking
#sudo systemctl restart networking

# setup physical in permiscous mode
sudo ifconfig enp0s31f6 promisc

echo cd /etc/libvirt/qemu

ip a s
ip r
ip -f inet a s

exit 0

sudo vi /etc/network/interfaces
 # bridge setup static ip enp0s31f6 - mintlinux
auto br0
 iface br0 inet static
    bridge_ports enp0s31f6
    address 192.168.10.20
    broadcast 192.168.10.255
    netmask 255.255.255.0
    gateway 192.168.10.1
    dns-nameservers 192.168.10.1

sudo vi /etc/netctl/bridge
sudo netctl enable bridge
# archlinux
# bridge setup DHCP enp9s0
# Description="bridge archlinux"
# Interface=br0
# Connection=bridge
# BindsToInterfaces=(enp9s0)
# IP=dhcp
#     bridge_ports enp9s0


# sudo vi /etc/netctl/enp9s0
# sudo netctl enable enp9s0
# Description="ethernet connection"
# Interface=enp9s0
# Connection=ethernet
# BindsToInterfaces=(enp9s0)
# IP=no


#Adding the line: nameserver 192.168.100.254 /etc/resolvconf/resolv.conf.d/head


#listen-address=192.168.100.217
#bind-interfaces
#systemctl restart dnsmasq

# manually set an ip address
sudo ip addr add 192.168.100.2/24 dev eth0
sudo ip link set eth0 up

echo 0 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables

#Adding an iptables rule:
sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT

iptables-persistent

sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
netfilter-persistent save
sudo cat /etc/iptables/rules.v4| grep bridge
sudo iptables -S | grep bridge

sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
sudo iptables-save | tee firewall.rules
sudo iptables-restore | tee firewall.rules
sudo sysctl -p


sudo systemctl edit --full rc-local

It appears you need to install the resolvconf package to use the dns-* values in /etc/network/interfaces
sudo rm /etc/resolv.conf
sudo dpkg-reconfigure resolvconf

# vim: set ft=sh:
