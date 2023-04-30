#!/bin/sh

cat <<  EOF > "$HOME/tmp/rc-local.service"
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

cat <<  EOF > "$HOME/tmp/rc.local"
#!/bin/sh

echo hellotest

exit 0
EOF

sudo mv -v "$HOME/tmp/rc.local" /etc/rc.local
sudo chmod 755 /etc/rc.local

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo mv -v "$HOME/tmp/rc-local.service" /etc/systemd/system/rc-local.service
  doas systemctl enable rc-local
  doas systemctl start rc-local
  doas systemctl status rc-local
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas systemctl stop getty@ttyS0
  doas systemctl disable getty@ttyS0
  sudo rm -vrf /lib/systemd/system/rc.service
  sudo mv -v "$HOME/tmp/rc-local.service" /lib/systemd/system/rc-local.service
  doas systemctl enable rc-local
  doas systemctl start rc-local
  doas systemctl status rc-local
elif [ "$OS" = "CentOS Linux" ]; then
  echo "TODO: work on centos"
  exit 1
elif [ "$OS" = "Gentoo" ]; then
  echo Gentoo openrc
  doas systemctl enable rc-local
  doas systemctl start rc-local
  doas systemctl status rc-local
else
  echo "$OS not configured."
  exit 1
fi

exit 0

# vim: set ft=sh:
