#!/bin/sh

cat > rc-local.service <<'EOF'
[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
EOF

cat > rc.local <<'EOF'
#!/bin/sh

echo hellotest

exit 0
EOF

sudo mv rc.local /etc/rc.local
sudo chmod 755 /etc/rc.local

if [ "$OS" = "Arch Linux" ]; then
  sudo mv -v rc-local.service /etc/systemd/system/rc-local.service
  sudo systemctl enable rc-local
  sudo systemctl start rc-local
  sudo systemctl status rc-local
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo systemctl stop getty@ttyS0
  sudo systemctl disable getty@ttyS0
  sudo rm -vrf /lib/systemd/system/rc.service
  sudo mv -v rc-local.service /lib/systemd/system/rc-local.service
  sudo systemctl enable rc-local
  sudo systemctl start rc-local
  sudo systemctl status rc-local
elif [ "$OS" = "CentOS Linux" ]; then
  echo "work on centos"
  exit 1
elif [ "$OS" = "CentOS Linux" ]; then
  echo Gentoo openrc
  exit 1
else
  echo $OS not configured.
  exit 1
fi

exit 0
