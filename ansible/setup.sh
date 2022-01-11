#!/bin/sh

cat > hosts <<'EOF'
[debian]
192.168.10.217
192.168.10.190
localhost

[archlinux]
102.168.10.208
EOF

sudo mkdir -p /etc/ansible
#sudo touch /etc/ansible/hosts
sudo mv hosts /etc/ansible/hosts

ansible debian -m ping

exit 0
