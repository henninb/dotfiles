#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nginx-inject-lua
  podman rm -f nginx-inject-lua
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop nginx-inject-lua
  docker rm -f nginx-inject-lua
  echo "running server on port 443"

  echo docker exec -it --user root nginx-inject-lua /bin/bash
  echo docker exec -it --user root nginx-inject-lua ss --listen
  echo docker logs nginx-inject-lua

  if command -v docker-compose; then
    docker compose build
    docker compose up
  else
    docker build -t nginx-inject-lua .
    docker run --name=nginx-inject-lua -h nginx-inject-lua -h nginx-inject-lua --restart unless-stopped -p 443:443 -d nginx-inject-lua
  fi
fi

exit 0
