#!/bin/sh

docker pull elasticsearch:7.6.2
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.6.2

# docker pull logstash:7.6.2
sudo pacman -S logstash

sudo /usr/share/logstash/bin/logstash-plugin install logstash-codec-sflow
sudo /usr/share/logstash/bin/logstash-plugin install logstash-codec-netflow
sudo /usr/share/logstash/bin/logstash-plugin update logstash-codec-netflow
sudo /usr/share/logstash/bin/logstash-plugin install logstash-input-udp
sudo /usr/share/logstash/bin/logstash-plugin update logstash-input-udp
sudo /usr/share/logstash/bin/logstash-plugin install logstash-filter-dns
sudo /usr/share/logstash/bin/logstash-plugin update logstash-filter-dns

git clone git@github.com:deviantony/docker-elk.git

echo elastic
echo changeme

exit 0
