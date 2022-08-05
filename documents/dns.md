ping goes through system resolving, meanwhile with dig you're sending requests directly. That's why there're different outcomes.

As to how to solve it — not using separate zone for hosts isn't best (or even good) practice. Say, mDNS (Multicast DNS) service shipped with Ubuntu 18.04 expects .local to be default zone unless it's explicitly specified.

If you don't need mDNS in your system of course you can just adjust /etc/nsswitch.conf accordingly. But in general (read "following best practices") 
you should have separate DNS zone for your LAN which you can have setup to be tried by default, even if you omit its name.
