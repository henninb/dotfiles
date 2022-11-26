#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop apache-server
  podman rm -f apache-server
  echo "running server on port 443"

  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop apache-server
  docker rm -f apache-server
  echo "running server on port 443"

  echo docker exec -it --user root apache-server /bin/bash
  echo docker exec -it --user root apache-server ss --listen
  echo docker logs apache-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t apache-server .
    docker run --name=apache-server -h apache-server -h apache-server --restart unless-stopped -p 8080:80 -d apache-server
  fi
fi

exit 0
