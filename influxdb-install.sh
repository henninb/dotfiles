#!/bin/sh

INFLUXDB_PASSWORD="********"

cat > influxdb.repo << 'EOF'
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF

cat > influxdb.conf <<'EOF'
[meta]
  dir = "/var/lib/influxdb/meta"
[data]
  dir = "/var/lib/influxdb/data"
  wal-dir = "/var/lib/influxdb/wal"
[coordinator]
[retention]
[shard-precreation]
[monitor]
[http]
  enabled = true
  bind-address = "0.0.0.0:8086"
  auth-enabled = false
[logging]
[subscriber]
[[graphite]]
[[collectd]]
[[opentsdb]]
[[udp]]
[continuous_queries]
[tls]
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y adduser libfontconfig
  sudo apt install -y influxdb influxdb-client
  sudo mv -v influxdb.conf /etc/influxdb/influxdb.conf
  sudo systemctl restart influxdb
  sudo systemctl status influxdb
  sudo systemctl enable influxdb
  echo "CREATE USER \"henninb\" WITH PASSWORD '${INFLUXDB_PASSWORD}' WITH ALL PRIVILEGES" | influx
  echo 'SHOW USERS' | influx
  sudo sed -i "s/# auth-enabled = false/auth-enabled = true/g" /etc/influxdb/influxdb.conf
  sudo systemctl restart influxdb
  sleep 4
  curl -G http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=SHOW DATABASES"
  curl -i -XPOST http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=CREATE DATABASE metrics"
  echo "netstat -na | grep LISTEN | grep tcp | grep 8086"
  netstat -na | grep LISTEN | grep tcp | grep 8086
  sudo fuser 8086/tcp
elif [ "$OS" = "Darwin" ]; then
  brew install influxdb
  echo influxd -config /usr/local/etc/influxdb.conf
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge influxdb
  sudo mv -v influxdb.conf /etc/influxdb/influxdb.conf
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S influxdb net-tools
  sudo mv -v influxdb.conf /etc/influxdb/influxdb.conf
  sudo systemctl restart influxdb
  sudo systemctl status influxdb
  sudo systemctl enable influxdb
  echo "CREATE USER \"henninb\" WITH PASSWORD '${INFLUXDB_PASSWORD}' WITH ALL PRIVILEGES" | influx
  echo 'SHOW USERS' | influx
  sudo sed -i "s/# auth-enabled = false/auth-enabled = true/g" /etc/influxdb/influxdb.conf
  sudo systemctl restart influxdb
  sleep 4
  curl -G http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=SHOW DATABASES"
  curl -i -XPOST http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=CREATE DATABASE metrics"
  echo "netstat -na | grep LISTEN | grep tcp | grep 8086"
  netstat -na | grep LISTEN | grep tcp | grep 8086
  sudo fuser 8086/tcp
elif [ "$OS" = "CentOS Linux" ]; then
  sudo mv influxdb.repo /etc/yum.repos.d/influxdb.repo
  sudo yum makecache fast
  sudo yum install -y influxdb net-tools
  sudo systemctl restart influxdb
  sudo systemctl status influxdb
  sudo systemctl enable influxdb
  echo "CREATE USER \"henninb\" WITH PASSWORD '${INFLUXDB_PASSWORD}' WITH ALL PRIVILEGES" | influx
  echo 'SHOW USERS' | influx
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
