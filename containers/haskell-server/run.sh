#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop haskell-server
  podman rm -f haskell-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop haskell-server
  docker rm -f haskell-server

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root haskell-server /bin/bash
  echo docker exec -it --user root haskell-server ss --listen
  echo docker logs haskell-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t haskell-server .
    docker run --name=haskell-server -h haskell-server -h haskell-server --restart unless-stopped -p 443:443 -d haskell-server
  fi
fi

exit 0
