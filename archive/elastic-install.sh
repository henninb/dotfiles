#!/bin/sh

cat > filebeat.yml <<EOF
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
output.elasticsearch:
  # hosts: ["192.168.100.208:9200"]
  hosts: ["192.168.100.226:9200"]
  # username: "elastic"
  # password: "changeme"
EOF

cat > elasticsearch.yml <<EOF
network.host: 0.0.0.0
cluster.name: "ubuntu-cluster"
# node.name: "myNode1"
discovery.seed_hosts: []
# xpack.license.self_generated.type: trial
# xpack.security.enabled: true
# xpack.monitoring.collection.enabled: true
EOF

sudo apt install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"
sudo apt install -y elasticsearch
echo /etc/elasticsearch/elasticsearch.yml

sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
netstat -na | grep LISTEN | grep tcp | grep 9200
netstat -na | grep LISTEN | grep tcp | grep 9300
#netstat -tulp
sudo fuser 9300/tcp
sudo fuser 9200/tcp

curl -X GET "http://localhost:9200/?pretty"
# curl -X GET 'http://localhost:9200/sample/_search' -u "elastic:changeme"
echo 9200 for REST communication
echo 9300 for nodes communication

if [ ! -f "filebeat-7.6.2-amd64.deb" ]; then
  curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb
fi

sudo dpkg -i filebeat-7.6.2-amd64.deb
sudo cp -v filebeat.yml /etc/filebeat/filebeat.yml
sudo systemctl enable filebeat
sudo systemctl start filebeat

exit 0
