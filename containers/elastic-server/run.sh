#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$OS" = "FreeBSD" ]; then
  HOST_IP="192.168.10.114"
elif [ "$OS" = "Darwin" ]; then
  HOST_IP=$(ipconfig getifaddr en0)
else
  HOST_IP=$(ip route get 1 | awk '{print $7}' | head -1)
fi

export HOST_IP

if [ "$platform" = "podman" ]; then
  # podman stop logstash-server
  # podman rm -f logstash-server
  podman stop elasticsearch-server
  podman rm -f elasticsearch-server
  podman stop kibana-server
  podman rm -f kibana-server
  podman volume rm elk-server_elasticsearch-volume
  echo "running server on port xx"

  echo docker logs kibana-server
  echo docker logs elasticsearch-server

  export elastic_host='host.containers.internal'
  podman-compose build
  podman-compose up -d

  echo "curl -s http://localhost:5601/api/status | jq '.status.overall'"
  curl -s http://localhost:5601/api/status | jq '.status.overall'

  echo 'curl -s -X GET "http://localhost:9200/_cluster/health" | jq'
  curl -s -X GET "http://localhost:9200/_cluster/health" | jq
elif [ "$platform" = "docker" ]; then
  # docker stop logstash-server
  # docker rm -f logstash-server
  docker stop elasticsearch-server
  docker rm -f elasticsearch-server
  docker stop kibana-server
  docker rm -f kibana-server
  docker volume rm elk-server_elasticsearch-volume
  echo "running server on port xx"

  export elastic_host='elasticsearch-server'
  echo docker logs kibana-server
  echo docker logs elasticsearch-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up -d

    echo "curl -s http://localhost:5601/api/status | jq '.status.overall'"
    curl -s http://localhost:5601/api/status | jq '.status.overall'

    echo 'curl -s -X GET "http://localhost:9200/_cluster/health" | jq'
    curl -s -X GET "http://localhost:9200/_cluster/health" | jq
  fi
fi

echo docker volume rm -f elastic-server_elasticsearch-volume

exit 0
