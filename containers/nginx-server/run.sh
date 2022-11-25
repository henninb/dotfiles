#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nginx-server
  podman rm -f nginx-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop nginx-server
  docker rm -f nginx-server
  echo "running server on port 443"

  echo docker exec -it --user root nginx-server /bin/bash
  echo docker exec -it --user root nginx-server ss --listen
  echo docker logs nginx-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t nginx-server .
    docker run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 443:443 -d nginx-server
  fi
fi

exit 0
