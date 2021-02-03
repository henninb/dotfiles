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
monitoring.elasticsearch.hosts=http://192.168.100.124:9200
EOF

mkdir -p "$HOME/logstash-data"
mkdir -p "$HOME/logstash-pipeline"

export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"


#docker run --name logstash-server -d --restart unless-stopped -p 4560:4560 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/logstash-data:/somedir" logstash:7.10.1

docker run --name logstash-server -d --restart unless-stopped -p 4560:4560 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/logstash-pipeline:/usr/share/logstash/pipeline" logstash:7.10.1

exit 0
