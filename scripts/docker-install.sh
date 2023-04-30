#!/bin/sh

cat > "$HOME/tmp/daemon.json" <<EOF
{ "dns" : [ "8.8.8.8", "8.8.4.4" ]}
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman  --noconfirm --needed -S docker
  doas pacman  --noconfirm --needed -S docker-compose
  doas systemctl enable docker
  doas systemctl start docker
  doas systemctl status docker
  echo "reboot seems to be required"
  doas netstat -lntp | grep dockerd
  sudo fuser 2375/tcp
  doas usermod -a -G docker "$(id -un)"
  echo "/etc/docker/daemon.json"
  sudo mkdir -p /etc/systemd/system/docker.socket.d
  echo "loop" | sudo tee /etc/modules-load.d/loop.conf
  echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward
  #sudo tee /etc/modules-load.d/loop.conf <<< "loop"
  #sudo tee /proc/sys/net/ipv4/ip_forward <<< 1
  doas sysctl -w net.ipv4.ip_forward=1
  doas iptables -t nat -L
  #sudo firewall-cmd --permanent --zone=trusted --change-interface=docker0
  #sudo firewall-cmd --reload
elif [ "$OS" = "Darwin" ]; then
  brew install docker
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y docker-compose
  doas xbps-install -y docker
  doas usermod -aG docker "$USER"
  sudo ln -sfn /etc/sv/docker /var/service/docker
  doas sv up docker
  doas sv status docker
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -y docker
  doas eopkg install -y docker-compose
  doas usermod -G docker -a "$USER"
  doas systemctl enable docker --now
  # sudo systemctl start docker
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y docker
  doas zypper install -y docker-compose
  doas usermod -G docker -a "$USER"
  doas systemctl enable docker --now
  # sudo systemctl start docker
  doas systemctl status docker
elif [ "$OS" = "Debian GNU/Linux" ]; then
  doas apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  doas apt update
  doas apt install -y docker-ce docker-ce-cli containerd.io
  doas apt install -y docker-compose
  doas usermod -G docker -a "$USER"
  doas systemctl enable docker --now
  # sudo systemctl start docker
  doas systemctl status docker
  sudo wget 'https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64' -O /usr/local/bin/docker-compose
elif [ "$OS" = "Ubuntu" ]; then
  doas snap install docker
  doas apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  doas apt update
  # sudo apt install -y docker
  doas systemctl enable docker --now
  doas systemctl start docker
  doas groupadd docker
  doas usermod -a -G docker "$(id -un)"
  doas netstat -lntp | grep dockerd
  sudo fuser 2375/tcp
elif [ "$OS" = "Linux Mint" ]; then
  doas apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  doas apt-key fingerprint 0EBFCD88
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable"
  doas apt update -y
  doas apt install -y docker-ce docker-compose
  doas systemctl enable docker --now
  doas systemctl start docker
  doas usermod -a -G docker "$(id -un)"
  doas netstat -lntp | grep dockerd
  sudo fuser 2375/tcp
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y device-mapper-persistent-data
  doas dnf install -y lvm2
  doas dnf install -y dnf-plugins-core
  doas dnf install -y psmisc
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  doas dnf install -y docker-ce docker-ce-cli containerd.io
  doas systemctl enable docker --now
  doas systemctl start docker
  doas usermod -aG docker "$(whoami)"
  doas netstat -lntp | grep dockerd
  sudo fuser 2375/tcp
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  doas systemctl enable docker --now
  doas systemctl start docker
  doas yum update -y
  doas yum install -y yum-utils device-mapper-persistent-data lvm2 docker-ce psmisc
  doas systemctl enable docker --now
  doas systemctl start docker
  doas chkconfig docker on
  doas usermod -aG docker "$(whoami)"
  doas netstat -lntp | grep dockerd
  sudo fuser 2375/tcp
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y docker
  doas pkg install -y ca_root_nss
  sudo sysrc -f /etc/rc.conf docker_enable="YES"
  doas service docker start
elif [ "$OS" = "Gentoo" ]; then
  doas eselect news read
  # sudo emerge --update --newuse sys-kernel/gentoo-sources
  # sudo emerge --update --newuse aufs-sources
  doas emerge --update --newuse fakeroot
  doas emerge --update --newuse pciutils
  sudo emerge --update --newuse sys-fs/btrfs-progs
  doas emerge --update --newuse docker-compose
  sudo emerge --update --newuse app-containers/docker
  doas systemctl enable docker --now
  # sudo rc-update add docker default
  # sudo rc-service docker start
  doas usermod -a -G docker "$(id -un)"
  echo /usr/share/docker/contrib/check-config.sh
  echo sudo mv -v "$HOME/tmp/daemon.json" /etc/docker/daemon.json
  echo "net.ipv4.ip_forward = 1" | tee -a  /etc/sysctl.conf
else
  echo "$OS is not yet implemented."
  exit 1
fi

if ! command -v docker-compose; then
  pip install docker-compose
fi

exit 0

# vim: set ft=sh:
