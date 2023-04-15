#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop openresty-plugin
  podman rm -f openresty-plugin
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop openresty-plugin
  docker rm -f openresty-plugin
  echo "running server on port 443"

  echo docker exec -it --user root openresty-plugin /bin/bash
  echo docker exec -it --user root openresty-plugin ss --listen
  echo docker logs openresty-plugin

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t openresty-plugin .
    docker run --name=openresty-plugin -h openresty-plugin -h openresty-plugin --restart unless-stopped -p 443:443 -d openresty-plugin
  fi
fi

exit 0
