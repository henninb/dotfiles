#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop mongodb-server
  podman rm -f mongodb-server
  echo "running server on port 443"

  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop mongodb-server
  docker rm -f mongodb-server
  echo "running server on port 443"

  echo docker exec -it --user root mongodb-server /bin/bash
  echo docker exec -it --user root mongodb-server ss --listen
  echo docker logs mongodb-server

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t mongodb-server .
    docker run --name=mongodb-server -h mongodb-server -h mongodb-server --restart unless-stopped -p 443:443 -d mongodb-server
  fi
fi

exit 0
