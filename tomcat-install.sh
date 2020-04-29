#!/bin/sh

RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')
TOMCAT_VER=8.5.46

cat > tomcat.service <<'EOF'
[Unit]
Description=tomcat server
After=network.target
[Service]
PIDFile=/opt/tomcat/temp/tomcat.pid
ExecStart=/opt/tomcat/bin/catalina.sh start
ExecStop=/opt/tomcat/bin/catalina.sh stop
User=root
Group=root
[Install]
WantedBy=multi-user.target
EOF

if [ ! \( -f "apache-tomcat-${TOMCAT_VER}.tar.gz" \) ]; then
  rm -rf apache-tomcat-*.tar.gz
  #wget "http://apache.cs.utah.edu/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz"
  curl -s "http://apache.cs.utah.edu/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz" --output "apache-tomcat-${TOMCAT_VER}.tar.gz"
else
  echo why
  exit 1
fi

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo groupadd tomcat
  sudo useradd -g tomcat tomcat
  sudo pacman --noconfirm --needed -S net-tools psmisc wget curl
  sudo tar -zxvf apache-tomcat-${TOMCAT_VER}.tar.gz -C /opt
  sudo ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat
  sudo chown -R tomcat:tomcat /opt/apache-tomcat-${TOMCAT_VER}
  sudo mv -v tomcat.service /lib/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable tomcat
  sudo systemctl start tomcat
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo zypper install curl wget
elif [ "$OS" = "FreeBSD" ]; then
  rm -rf tomcat.service
elif [ "$OS" = "Gentoo" ]; then
  sudo tar -zxvf apache-tomcat-${TOMCAT_VER}.tar.gz -C /opt
  sudo ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo groupadd tomcat
  sudo useradd -g tomcat tomcat
  sudo apt install -y net-tools psmisc wget curl
  sudo tar -zxvf apache-tomcat-${TOMCAT_VER}.tar.gz -C /opt
  sudo ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat
  sudo chown -R tomcat:tomcat /opt/apache-tomcat-${TOMCAT_VER}
  sudo mv -v tomcat.service /lib/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable tomcat
  sudo systemctl start tomcat
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y net-tools wget curl java-1.8.0-openjdk
  sudo tar -zxvf apache-tomcat-${TOMCAT_VER}.tar.gz -C /opt
  sudo ln -s /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
