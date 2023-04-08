#!/bin/sh

systemd-resolve --status


echo fedora
echo /etc/resolv.conf -> ../run/systemd/resolve/stub-resolv.conf

exit 0
