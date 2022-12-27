#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

export HOST_IP=192.168.10.192
docker volume ls

if [ "$platform" = "podman" ]; then
  # podman stop logstash-server
  # podman rm -f logstash-server
  podman stop elasticsearch-server
  podman rm -f elasticsearch-server
  podman stop kibana-server
  podman rm -f kibana-server
  podman volume rm elk-server_elasticsearch-volume
  echo "running server on port xx"

  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  # docker stop logstash-server
  # docker rm -f logstash-server
  docker stop elasticsearch-server
  docker rm -f elasticsearch-server
  docker stop kibana-server
  docker rm -f kibana-server
  docker volume rm elk-server_elasticsearch-volume
  echo "running server on port xx"

  echo docker logs kibana-server
  echo docker logs elasticsearch-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  fi
fi

echo docker volume rm -f elastic-server_elasticsearch-volume

exit 0
