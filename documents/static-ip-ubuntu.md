# ip addr show
# sudo vi /etc/netplan/01-netcfg.yaml
# sudo netplan apply
# ip addr show dev ens18
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
      dhcp4: no
      addresses:
        - 192.168.100.10/24
      gateway4: 192.168.100.1
      nameservers:
          addresses: [8.8.8.8, 1.1.1.1]
