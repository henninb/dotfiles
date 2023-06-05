#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nginx-server-hosted
  podman rm -f nginx-server-hosted
  echo "running server on port 443"

  podman-compose build
  podman-compose up
  # podman build -t nginx-server-hosted .
  # podman run --name=nginx-server-hosted -h nginx-server-hosted -h nginx-server-hosted --restart unless-stopped -p 443:443 -d nginx-server-hosted
elif [ "$platform" = "docker" ]; then
  docker stop nginx-server-hosted
  docker rm -f nginx-server-hosted
  echo "running server on port 443"

  echo docker exec -it --user root nginx-server-hosted /bin/bash
  echo docker exec -it --user root nginx-server-hosted ss --listen
  echo docker logs nginx-server-hosted

  if command -v docker-compose; then
    docker compose build
    docker compose up
  else
    docker build -t nginx-server-hosted .
    docker run --name=nginx-server-hosted -h nginx-server-hosted -h nginx-server-hosted --restart unless-stopped -p 443:443 -d nginx-server-hosted
  fi
fi

exit 0
