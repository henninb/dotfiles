sudo apt install isc-dhcp-server

#INTERFACESv4="enp1s10 enx00e04c534458"
INTERFACESv4="enp1s10"
INTERFACESv6=""


/etc/dhcp/dhcpd.conf
subnet 192.168.10.0 netmask 255.255.255.0 {
 range 192.168.10.101 192.168.10.200;
 interface enp1s10;
 option domain-name-servers 8.8.8.8, 8.8.8.4;
 option routers 192.168.10.1;
 option subnet-mask 255.255.255.0;
 option broadcast-address 192.168.10.255;
}

subnet 192.168.20.0 netmask 255.255.255.0 {
 range 192.168.20.101 192.168.20.200;
 interface enx00e04c534458;
 option domain-name-servers 8.8.8.8, 8.8.8.4;
 option routers 192.168.20.1;
 option subnet-mask 255.255.255.0;
 option broadcast-address 192.168.20.255;
}


sudo lshw -C network


/etc/network/interfaces
auto enp0s7
iface enp0s7 inet dhcp

auto enp1s10
iface enp1s10 inet static
  address 192.168.10.1
  netmask 255.255.255.0
  gateway 192.168.10.1
  network 192.168.10.0
  broadcast 192.168.10.255

auto enx00e04c534458
iface enx00e04c534458 inet static
  address 192.168.20.1
  netmask 255.255.255.0
  gateway 192.168.20.1
  network 192.168.20.0
  broadcast 192.168.20.255


sudo iptables -t nat -A POSTROUTING -o enp0s7 -j MASQUERADE
sudo apt install iptables-persistent
sudo iptables-save | sudo tee /etc/iptables/rules.v4
