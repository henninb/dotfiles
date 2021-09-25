# ddwrt

Services:
Additional Dnsmasq Options:

```
address=/youtube.com/127.0.0.1
address=/www.youtube.com/127.0.0.1
address=/googlevideo.com/127.0.0.1
address=/ytimg.com/127.0.0.1
address=/m.youtube.com/127.0.0.1
address=/www.m.youtube.com/127.0.0.1
address=/youtube-ui.l.google.com/127.0.0.1
address=/ytimg.l.google.com/127.0.0.1
address=/ytstatic.l.google.com/127.0.0.1
address=/youtubei.googleapis.com/127.0.0.1
```

## firewall
```
Firewall config:
# block anything that falls through (just a precaution)
iptables -I FORWARD -i br+ -o br+ -j DROP

# deny iot network access to any other networks
iptables -I FORWARD -i br1 -o br+ -j DROP

# allow private network access to any other networks
iptables -I FORWARD -i br0 -o br+ -j ACCEPT

# push RELATED/ESTABLISHED rule back to top of chain
iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
```
