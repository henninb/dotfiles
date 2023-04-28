#!/bin/sh

echo "Ctrl + q is to quit."
echo "Press [Enter] key to continue..."
read -r x
echo "$x" > /dev/null

mkdir -p "$HOME/torrent"
rtorrent http://sjc.edge.kernel.org/centos/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.torrent
mv CentOS-7-x86_64-Minimal-1810 "$HOME/torrent"

exit 0

# vim: set ft=sh:
