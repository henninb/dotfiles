#!/bin/sh

export PATH=/opt/kafka/bin:$PATH

#https://www.apache.org/dyn/closer.cgi?path=/kafka/2.2.0/kafka_2.12-2.2.0.tgz
#https://kafka.apache.org/downloads

SCALA_VER=2.12
NUM=$(curl -sf https://kafka.apache.org/downloads | grep -o "kafka_${SCALA_VER}-[0-9.]\+[0-9]" | head -1 | sed 's/kafka_[0-9.]\+[0-9]-//')
VER="${SCALA_VER}-${NUM}"
FILE="kafka_${VER}"

if [ ! -f "kafka_${VER}.tgz" ]; then
  rm -rf kafka_*.tgz
  curl -s https://archive.apache.org/dist/kafka/${NUM}/kafka_${VER}.tgz --output kafka_${VER}.tgz
fi

sudo rm -rf /opt/kafka
sudo rm -rf /opt/kafka_${VER}
sudo tar -zxvf kafka_${VER}.tgz -C /opt
sudo ln -s /opt/kafka_${VER} /opt/kafka
sudo useradd -s /sbin/nologin kafka -m
sudo chown -R kafka:kafka /opt/kafka/
sudo chown -R kafka:kafka /opt/kafka_${VER}/

sudo sed -i "s/#listeners=PLAINTEXT:\/\/:9092/listeners=PLAINTEXT:\/\/:9092,SSL:\/\/:9093/g" /opt/kafka/config/server.properties
sudo sed -i "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/:9092,SSL:\/\/:9093/g" /opt/kafka/config/server.properties

cat > zookeeper.service <<'EOF'
[Unit]
Description=Apache Zookeeper server (Kafka)
Documentation=http://zookeeper.apache.org
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
Group=kafka
#Environment=JAVA_HOME=/usr/lib/jvm/default
#Environment=JAVA_HOME=/usr/lib/jvm/default-java
ExecStart=/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties
ExecStop=/opt/kafka/bin/zookeeper-server-stop.sh

[Install]
WantedBy=multi-user.target
EOF

cat > kafka.service <<'EOF'
[Unit]
Description=Apache Kafka server (broker)
Documentation=http://kafka.apache.org/documentation.html
Requires=network.target remote-fs.target
After=network.target remote-fs.target zookeeper.service

[Service]
Type=simple
User=kafka
Group=kafka
#Environment=JAVA_HOME=/usr/lib/jvm/default
#Environment=JAVA_HOME=/usr/lib/jvm/default-java
ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
ExecStop=/opt/kafka/bin/kafka-server-stop.sh

[Install]
WantedBy=multi-user.target
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S net-tools psmisc wget curl jdk8-openjdk
  sudo mv -v kafka.service /etc/systemd/system/
  sudo mv -v zookeeper.service /etc/systemd/system/

  sudo systemctl daemon-reload
  sudo systemctl enable zookeeper
  sudo systemctl enable kafka
  sudo systemctl start zookeeper
  sudo systemctl start kafka
  sudo systemctl status kafka
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y net-tools psmisc wget curl openjdk-8-jdk
  sudo update-alternatives --config java
  sudo mv -v kafka.service /lib/systemd/system
  sudo mv -v zookeeper.service /lib/systemd/system
  sudo systemctl daemon-reload
  sudo systemctl enable zookeeper
  sudo systemctl enable kafka
  sudo systemctl start zookeeper
  sudo systemctl start kafka
  sudo systemctl status kafka
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y net-tools wget curl java-1.8.0-openjdk
  sudo mv -v kafka.service /etc/systemd/system
  sudo mv -v zookeeper.service /etc/systemd/system
  sudo systemctl enable zookeeper
  sudo systemctl enable kafka

  sudo systemctl daemon-reload
  sudo systemctl start zookeeper
  sudo systemctl start kafka
  sudo systemctl status kafka
else
  echo $OS is not yet implemented.
  exit 1
fi

read -p "Press enter to continue"

netstat -na | grep LISTEN | grep tcp | grep 9092
netstat -na | grep LISTEN | grep tcp | grep 2181

sudo fuser 2181/tcp
sudo fuser 9092/tcp
sudo fuser 9093/tcp

echo 'kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot'
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot

exit 0
