# backup
pihole -a -t

# restore
http://192.168.10.10/admin/settings.php?tab=teleporter


# update
pihole -up

## restart dns
pihole restartdns



## custom dns entries
sudo vim /etc/pihole/custom.list
