#!/bin/sh

systemd-resolve --status

# Global
#        Protocols: LLMNR=resolve -mDNS -DNSOverTLS DNSSEC=no/unsupported
# resolv.conf mode: stub


echo fedora
echo /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf

exit 0
