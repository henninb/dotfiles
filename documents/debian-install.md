# debian install

## select install

## select english

## select united states

## select American English

## enter the hostname
```
debian
```

## enter the domain
```
local
```

## enter the root password


## enter a name

## enter a username

## enter the password

## select your timezone

## guided - use entire disk

## all files in one partition

## finish partitoning and write changes to disk.

## write the changes to disk (yes)

## scan extra installation media? No

## select the mirror
```
United States
```

## select the mirror server
```
deb.debian.org
```

## skip the proxy
```
continue
```

## send developer statistics
```
no
```


## select packages
```
unselect desktop environment
unselect gnome
select ssh server
```


## install grub
```
yes
```

## select the drive
```
/dev/sda
```

## reboot
```
press continue
```

## static ip setup
```
sudo cp /etc/network/interfaces /etc/network/interfaces-bak

# The loopback network interface
auto lo
iface lo inet loopback

auto ens18
iface ens18 inet static
address 192.168.10.10
netmask 255.255.255.0
gateway 192.168.10.1
dns-nameservers 8.8.4.4 8.8.8.8

sudo systemctl restart networking.service
```
