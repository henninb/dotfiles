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
```
