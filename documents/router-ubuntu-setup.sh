#!/bin/sh

dest=192.168.100.122
wan=eno1
lan1=enp2s0
lan2=enp3s0

scp "$HOME/.ssh/id_rsa" henninb@${dest}:/home/henninb/.ssh
scp "$HOME/.ssh/authorized_keys" henninb@${dest}:/home/henninb/.ssh
scp "$HOME/.ssh/config" henninb@${dest}:/home/henninb/.ssh
ssh henninb@192.168.100.122 "echo '%sudo ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers"
echo '%sudo ALL=(ALL) NOPASSWD: ALL'
ssh henninb@${dest} "sudo apt install -y pppoeconf"
ssh henninb@${dest} "sudo apt install -y isc-dhcp-server"
ssh henninb@${dest} "sudo apt install -y net-tools"


cat > isc-dhcp-server <<EOF
INTERFACESv4="${lan1} ${lan2}"
INTERFACESv6=""
EOF

cat > dhcpd.conf <<EOF
subnet 192.168.10.0 netmask 255.255.255.0 {
 range 192.168.10.101 192.168.10.200;
 interface ${lan1};
 option domain-name-servers 8.8.8.8, 8.8.8.4;
 option routers 192.168.10.1;
 option subnet-mask 255.255.255.0;
 option broadcast-address 192.168.10.255;
}

subnet 192.168.20.0 netmask 255.255.255.0 {
 range 192.168.20.101 192.168.20.200;
 interface ${lan2};
 option domain-name-servers 8.8.8.8, 8.8.8.4;
 option routers 192.168.20.1;
 option subnet-mask 255.255.255.0;
 option broadcast-address 192.168.20.255;
}
EOF

cat > 50-setup.yaml <<EOF
#sudo netplan --debug generate  # generate the config files
#sudo netplan apply            # apply the new configuration
#reboot                        # reboot the computer
network:
  version: 2
  renderer: networkd
  ethernets:
    ${wan}:
      dhcp4: true
      optional: true
    ${lan1}:
      dhcp4: false
      optional: true
      addresses: [192.168.10.1/24]
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
    ${lan2}:
      dhcp4: false
      optional: true
      addresses: [192.168.20.1/24]
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
EOF


cat > iptables-ubuntu-setup.sh << EOF
#!/bin/sh

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
sudo iptables -A INPUT -i ${lan1} -j ACCEPT
sudo iptables -A INPUT -i ${lan2} -j ACCEPT

sudo iptables -A FORWARD -i ppp0 -o ${lan1} -j DROP
sudo iptables -A FORWARD -i ppp0 -o ${lan2} -j DROP
sudo iptables -A FORWARD -i ${wan} -o ${lan1} -j DROP
sudo iptables -A FORWARD -i ${wan} -o ${lan2} -j DROP
#sudo iptables -A FORWARD -s 192.168.2.0/24 -d 192.168.1.0/24 -j DROP

# Forward WAN packets to the LAN if the LAN initiated the connection.
sudo iptables -A FORWARD -i ${wan} -o ${lan1} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ${wan} -o ${lan2} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ppp0 -o ${lan1} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i ppp0 -o ${lan2} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#sudo dpkg-reconfigure iptables-persistent

# NAT traffic going out the WAN interface.
sudo iptables -t nat -A POSTROUTING -o ${wan} -j MASQUERADE
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
EOF

chmod 755 iptables-ubuntu-setup.sh
scp isc-dhcp-server dhcpd.conf 50-setup.yaml iptables-ubuntu-setup.sh henninb@${dest}:/home/henninb

ssh henninb@${dest} "sudo cp dhcp.conf /etc/dhcp/"
ssh henninb@${dest} "sudo cp 50-setup.yaml /etc/netplan/"
ssh henninb@${dest} "sudo cp isc-dhcp-server /etc/default/"

echo sudo sysctl -w net.ipv4.ip_forward=1
echo 'echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf'
echo cat /etc/sysctl.conf
echo sudo pppoeconf

exit 0

