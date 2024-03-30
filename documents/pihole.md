# pihole commands

## backup
```
pihole -a -t
docker exec pihole-server pihole -a -t
```

## backup and restore
http://192.168.10.10/admin/settings.php?tab=teleporter


## reset password
```
pihole -a -p
docker exec pihole-server pihole -a -p
```

# update
```
docker exec pihole-server pihole -up
pihole -up
```

## restart dns
```
pihole restartdns
```



## custom dns entries
sudo vim /etc/pihole/custom.list

## pihole version
```
docker exec pihole-server pihole -v
pihole -v
```

dns server validation
```
dig @192.168.10.10 google.com
docker exec -it pihole-server dig www.google.com

 ➜ nc -z -v 192.168.10.10 53
finance.lan [192.168.10.10] 53 (domain) open
```

pihole/pihole:latest     "/s6-init"0.0.0.0:53->53/tcp, :::53->53/tcp, 0.0.0.0:80->80/tcp, 0.0.0.0:53->53/udp, :::80->80/tcp, :::53->53/udp, 67/udp   pihole-server
pihole/pihole:latest     "/s6-init"              53/udp, 53/tcp, 67/udp, 0.0.0.0:80->80/tcp, :::80->80/tcp   pihole-server
