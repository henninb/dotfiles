#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nextcloud-server
  podman rm -f nextcloud-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop nextcloud-server
  echo docker rm -f nextcloud-server
  docker rm -f nextcloud-server
  # echo "running server on port 443"

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    echo stop
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root nextcloud-server /bin/bash
  echo docker exec -it --user root nextcloud-server ss --listen
  echo docker logs nextcloud-server

  if command -v docker-compose; then
    docker compose build
    docker compose up -d
  else
    docker build -t nextcloud-server .
    docker run --name=nextcloud-server -h nextcloud-server -h nextcloud-server --restart unless-stopped -p 443:443 -d nextcloud-server
  fi
fi

exit 0
