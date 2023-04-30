#!/bin/sh

cat <<  EOF > "$HOME/tmp/ntpd.service"
[Unit]
Description=Network Time Service
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/ntpd -g -u ntp:ntp -p /var/run/ntpd.pid
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  date
  doas ntpdate -u time.nist.gov
  date
  # sudo hwclock
  # sudo hwclock -w
elif [ "$OS" = "Gentoo" ]; then
  #sudo cp -v $HOME/tmp/ntpd.service /etc/systemd/system/ntpd.service
  date
  # sudo ntpdate -s time.nist.gov
  doas ntpdate -u pool.ntp.org
  date
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo doas systemctl unmask systemd-timesyncd.service
  doas apt install -y systemd-timesyncd
  date
  doas ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Void" ]; then
  date
  doas ntpdate -u time.nist.gov
  date
elif [ "$OS" = "FreeBSD" ]; then
  date
  doas ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  date
  doas ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Fedora Linux" ]; then
  date
  doas ntpdate -u time.nist.gov
  date
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

doas hwclock --systohc --localtime
doas hwclock --show

if command -v systemctl; then
  doas systemctl enable systemd-timesyncd.service --now
fi
# echo clock_systohc="YES" | sudo tee -a /etc/conf.d/hwclock
if command -v timedatectl; then
  doas timedatectl set-ntp true
  sudo timedatectl set-timezone America/Chicago
  doas timedatectl set-local-rtc 0
  timedatectl status
  echo timedatectl show-timesync --all
else
  echo time sync is it running?
fi

echo example:
echo "sudo date -s '27 DEC 2021 12:24:00'"

exit 0

# vim: set ft=sh:
