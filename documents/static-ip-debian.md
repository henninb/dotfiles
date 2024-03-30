## static-ip debian

## edit the interfaces file
```
sudo vi /etc/network/interfaces
```

## the interface name can vary
```
auto ens18
iface ens18 inet static
address 192.168.10.10
netmask 255.255.255.0
gateway 192.168.10.1
dns-nameservers 8.8.4.4 8.8.8.8
```


## restart network manager
```
sudo systemctl restart NetworkManager.service
```
