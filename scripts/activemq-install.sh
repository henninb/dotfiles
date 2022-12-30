#!/usr/bin/env sh

ACTIVEMQ_PASSWORD="********"

stty -echo
printf "Please enter the activemq password: "
read -r ACTIVEMQ_PASSWORD
export ACTIVEMQ_PASSWORD
stty echo
printf "\n"

# amq_version=$(curl -sfA 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0' 'http://activemq.apache.org/components/classic/download/' | grep -o 'ActiveMQ [0-9.]\+[0-9]' | sed 's/ActiveMQ //')

# amq_version=5.16.3
amq_version=5.17.3

#cat > activemq.service <<EOF
cat <<  EOF > "$HOME/tmp/activemq.service"
[Unit]
Description=activemq message queue
After=network.target
[Service]
PIDFile=/opt/activemq/data/activemq.pid
ExecStart=/opt/activemq/bin/activemq start
ExecStop=/opt/activemq/bin/activemq stop
User=root
Group=root
[Install]
WantedBy=multi-user.target
EOF

#cat > activemq.start <<EOF
cat <<  EOF > "$HOME/tmp/activemq.start"
#!/bin/sh
/opt/activemq/bin/activemq start
EOF

#cat > activemq.stop <<EOF
cat <<  EOF > "$HOME/tmp/activemq.stop"
#!/bin/sh
/opt/activemq/bin/activemq stop
EOF

if [ ! -f "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" ]; then
  # rm -rf "$HOME/tmp/apache-activemq-*bin.tar.gz"
  # scp "pi@pi:/home/pi/downloads/apache-activemq-$amq_version-bin.tar.gz" "$HOME/tmp/"
  if ! curl -s "https://archive.apache.org/dist/activemq/$amq_version/apache-activemq-$amq_version-bin.tar.gz" --output "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" ; then
    #scp "apache-activemq-$amq_version-bin.tar.gz" "pi@pi:/home/pi/downloads/"
    echo "could not download apache-activemq-$amq_version-bin.tar.gz"
    exit 1
  fi
fi

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo groupadd activemq
  sudo useradd -s /sbin/nologin -g activemq activemq
  sudo pacman --noconfirm --needed -S net-tools psmisc curl
  sudo tar -zxvf "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" -C /opt
  sudo chown -R activemq:activemq "/opt/apache-activemq-$amq_version/"
  sudo ln -sfn "/opt/apache-activemq-$amq_version" /opt/activemq
  sudo sed -i "s/managementContext createConnector=\"false\"/managementContext createConnector=\"true\"/" /opt/activemq/conf/activemq.xml
  sudo mv -v "$HOME/tmp/activemq.service" /usr/lib/systemd/system/activemq.service
  #sed -i "s/admin: admin, admin/admin: admin, ${ACTIVEMQ_PASSWORD}/g" /opt/activemq/conf/jetty-realm.properties
  sudo systemctl daemon-reload
  sudo systemctl enable activemq
  sudo systemctl start activemq
  sudo systemctl status activemq
  sleep 3
  curl -I http://localhost:8161
  netstat -na | grep tcp | grep LIST | grep 8161
  netstat -na | grep tcp | grep LIST | grep 61616
  netstat -na | grep tcp | grep LIST | grep 61613
  sudo fuser 8161/tcp
  sudo fuser 61616/tcp
  sudo fuser 61613/tcp
  echo "admin:admin"
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo groupadd activemq
  sudo useradd -s /sbin/nologin -g activemq activemq
  sudo zypper install curl wget
  sudo tar -zxvf "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" -C /opt
  sudo chown -R activemq:activemq "/opt/apache-activemq-$amq_version/"
  sudo ln -sfn "/opt/apache-activemq-$amq_version" /opt/activemq
  sudo sed -i "s/managementContext createConnector=\"false\"/managementContext createConnector=\"true\"/" /opt/activemq/conf/activemq.xml
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y activemq
  count=$(grep -c 1 "fdesc /dev/fd fdescfs rw 0 0" /etc/fstab)
  if [ "$count" -ne 1 ]; then
    echo "fdesc /dev/fd fdescfs rw 0 0" | sudo tee /etc/fstab
  fi

  count=$(grep -c "proc /proc procfs rw 0 0" /etc/fstab)
  if [ "$count" -ne 1 ]; then
    echo "proc /proc procfs rw 0 0" | sudo tee /etc/fstab
  fi
  sudo sysrc activemq_enable="YES"
  sudo service activemq start
  netstat -na | grep tcp | grep LIST | grep 8161
  netstat -na | grep tcp | grep LIST | grep 61616
  netstat -na | grep tcp | grep LIST | grep 61613
  rm -rf activemq.service
elif [ "$OS" = "Gentoo" ]; then
  sudo mv -v "$HOME/tmp/activemq.service" /usr/lib/systemd/system/activemq.service
  sudo groupadd activemq
  sudo useradd -s /sbin/nologin -g activemq activemq
  sudo eselect news read
  sudo groupadd activemq
  sudo useradd -s /sbin/nologin -g activemq activemq
  sudo tar -zxvf "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" -C /opt
  sudo chown -R activemq:activemq "/opt/apache-activemq-$amq_version/"
  sudo ln -sfn "/opt/apache-activemq-$amq_version" /opt/activemq
  # sudo mv -v "$HOME/tmp/activemq.start" /etc/local.d/
  # sudo mv -v "$HOME/tmp/activemq.stop" /etc/local.d/
  # sudo rc-update add activemq default
  # sudo rc-service activemq start
  sudo systemctl stop activemq
  sudo systemctl daemon-reload
  sudo systemctl enable activemq
  sudo systemctl start activemq
  sudo systemctl status activemq
  sleep 3
  curl -I http://localhost:8161
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y net-tools psmisc wget curl
  sudo tar -zxvf "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" -C /opt
  sudo chown -R activemq:activemq "/opt/apache-activemq-$amq_version/"
  sudo ln -sfn "/opt/apache-activemq-$amq_version" /opt/activemq
  sudo sed -i "s/managementContext createConnector=\"false\"/managementContext createConnector=\"true\"/" /opt/activemq/conf/activemq.xml
  sudo mv -v "$HOME/tmp/activemq.service" /lib/systemd/system
  #sudo mv -v "$HOME/tmp/activemq.service" /usr/lib/systemd/system/activemq.service
  #sed -i "s/admin: admin, admin/admin: admin, ${ACTIVEMQ_PASSWORD}/g" /opt/activemq/conf/jetty-realm.properties
  sudo systemctl daemon-reload
  sudo systemctl enable activemq
  sudo systemctl start activemq
  netstat -na | grep tcp | grep LIST | grep 8161
  netstat -na | grep tcp | grep LIST | grep 61616
  netstat -na | grep tcp | grep LIST | grep 61613
  pidof systemd
elif [ "$OS" = "Fedora Linux" ]; then
  sudo groupadd activemq
  sudo useradd -s /sbin/nologin -g activemq activemq
  sudo yum install -y net-tools wget curl
  sudo tar -zxvf "$HOME/tmp/apache-activemq-$amq_version-bin.tar.gz" -C /opt
  sudo chown -R activemq:activemq "/opt/apache-activemq-$amq_version/"
  sudo ln -sfn "/opt/apache-activemq-$amq_version /opt/activemq"
  sudo sed -i "s/managementContext createConnector=\"false\"/managementContext createConnector=\"true\"/" /opt/activemq/conf/activemq.xml
  sudo mv -v activemq.service /etc/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable activemq
  sudo systemctl start activemq
  echo fix the firewall
  netstat -na | grep tcp | grep LIST | grep 8161
  netstat -na | grep tcp | grep LIST | grep 61616
  netstat -na | grep tcp | grep LIST | grep 61613
  pidof systemd
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
