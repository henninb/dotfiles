#!/bin/sh

domain="office.dyn.yourdomain.com"
pass="secret"
while true; do
  newaddr=$(ifconfig egress | grep inet | grep -v fe80:: | head -n 1 | cut -d' ' -f2)
  if [ "$newaddr" != "$oldaddr" ]; then
    ftp -o /tmp/dyndns.log "http://$domain:$pass@dyn.dns.he.net/nic/update?hostname=$domain"
    res=`cat /tmp/dyndns.log`
    logger "Address changed from $oldaddr to $newaddr, updated dynamic DNS, response $res"
  fi
  oldaddr=$newaddr
  sleep 1
done

exit 0

# vim: set ft=sh:
