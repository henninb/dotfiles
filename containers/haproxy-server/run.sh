#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop haproxy-server
  podman rm -f haproxy-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop haproxy-server
  echo docker rm -f haproxy-server
  docker rm -f haproxy-server
  # echo "running server on port 443"

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    echo stop
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root haproxy-server /bin/bash
  echo docker exec -it --user root haproxy-server ss --listen
  echo docker logs haproxy-server

  if command -v docker-compose; then
    # docker network create --driver=bridge mynetwork
    # docker run -d --name web1 --net mynetwork jmalloc/echo-server:latest
    # docker run -d --name web2 --net mynetwork jmalloc/echo-server:latest
    # docker run -d --name web3 --net mynetwork jmalloc/echo-server:latest
    docker compose build
    docker compose up -d
  else
    docker build -t haproxy-server .
    docker run --name=haproxy-server -h haproxy-server -h haproxy-server --restart unless-stopped -p 443:443 -d haproxy-server
  fi
fi

exit 0
