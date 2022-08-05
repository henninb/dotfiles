ping goes through system resolving, meanwhile with dig you're sending requests directly. That's why there're different outcomes.

As to how to solve it — not using separate zone for hosts isn't best (or even good) practice. Say, mDNS (Multicast DNS) service shipped with Ubuntu 18.04 expects .local to be default zone unless it's explicitly specified.

If you don't need mDNS in your system of course you can just adjust /etc/nsswitch.conf accordingly. But in general (read "following best practices") 
you should have separate DNS zone for your LAN which you can have setup to be tried by default, even if you omit its name.



Update - as you say in the comments, your nsswitch.conf has:

hosts: files mdns4_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns myhostname
This means that hosts resolution will first look in /etc/hosts, and then use mdns4_minimal, which implied that youre using the avahi daemon service, perhaps this isnt running? If it fails to resolve using mdns, host resolution will fail - this is usually by design, to ensure that resolution is sure to use avahi, the fact that youve got resolve [!UNAVAIL=return] after this, means that the systemd resolver may be configured too... [!UNAVAILBLE=return] means that systemd-resolved will always be used if its up, but continue to nss-dns if not. So, determine how you want to resolve names to addresses, if you arent using mdns you can remove mdns4_minimal [NOTFOUND=return] so this may be better for you:

hosts: files resolve [!UNAVAIL=return] dns myhostname
or even:

hosts: files dns myhostname
