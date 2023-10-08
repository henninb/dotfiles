#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop authelia-server
  podman rm -f authelia-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop authelia-server
  echo docker rm -f authelia-server
  docker rm -f authelia-server
  # echo "running server on port 443"

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    echo stop
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root authelia-server /bin/bash
  echo docker exec -it --user root authelia-server ss --listen
  echo docker logs authelia-server

  if command -v docker-compose; then
    docker compose build
    docker compose up -d
  else
    docker build -t authelia-server .
    docker run --name=authelia-server -h authelia-server -h authelia-server --restart unless-stopped -p 443:443 -d authelia-server
  fi
fi

exit 0
