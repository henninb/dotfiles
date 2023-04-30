#!/bin/sh

mkdir -p "/opt/jails/"
sudo bsdinstall jail "/opt/jails/www"


cat << EOF > "$HOME/tmp/jail.conf"
www {
   host.hostname = www.lan;
   ip4.addr = 192.168.10.27;
   path = /home/henninb/jails/www;
   mount.devfs;
   exec.start = "/bin/sh /etc/rc";
   exec.stop = "/bin/sh /etc/rc.shutdown";
}
EOF

sudo cp -v "$HOME/tmp/jail.conf" /etc/jail.conf
doas sysrc jail_enable=YES
echo 'ifconfig_re0_alias0="inet 192.168.10.27"'
doas service jail start www
jls
doas jexec 1 csh

exit 0

# vim: set ft=sh:
