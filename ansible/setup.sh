#!/bin/sh

cat > hosts <<'EOF'
[debian]
192.168.100.217
192.168.100.190
localhost

[archlinux]
102.168.100.208
EOF

sudo mkdir -p /etc/ansible
#sudo touch /etc/ansible/hosts
sudo mv hosts /etc/ansible/hosts

ansible debian -m ping

exit 0
