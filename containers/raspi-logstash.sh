#!/bin/sh

cat > logstash.conf <<EOF
input {
  tcp {
    port => 4560
    codec => json_lines
  }
}

filter {
}

output {
#  stdout {
#  }
  elasticsearch {
    hosts => ["hornsup:9200"]
    index => "prod"
  }
}
EOF

cat > logstash.env <<EOF
monitoring.elasticsearch.hosts=http://192.168.10.25:9200
EOF

mkdir -p "$HOME/logstash-data"
mkdir -p "$HOME/logstash-pipeline"

export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"

ssh pi mkdir -p "/home/pi/logstash-data"
ssh pi sudo chown -R $CURRENT_UID:$CURRENT_GID /home/pi/logstash-data
ssh pi sudo chmod -R 770 /home/pi/logstash-data

export DOCKER_HOST=ssh://pi@192.168.10.25
docker rm -f logstash-server
docker run --name logstash-server -d --restart unless-stopped -p 4560:4560 --env-file logstash.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/logstash-pipeline:/usr/share/logstash/pipeline" logstash:8:13.1

exit 0
