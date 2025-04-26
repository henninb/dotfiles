#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  export PODMAN_HOST=ssh://henninb@192.168.10.10/run/user/1000/podman/podman.sock
  export CONTAINER_HOST=ssh://henninb@192.168.10.10/run/user/1000/podman/podman.sock
  podman stop nginx-server
  podman rm -f nginx-server
  # echo "running server on port 443"

  # export PODMAN_COMPOSE_WARNING_LOGS=false
  # export PODMAN_COMPOSE_PROVIDER=podman-compose
  # export PODMAN_HOST=ssh://henninb@192.168.10.10
  # podman info
  #podman build -t nginx-server .
  podman --remote info | grep 'debian'

  podman images
  # podman build -t nginx-server .
  # podman run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 7443:443 -d nginx-server
  podman compose build
  podman compose up -d
  podman ps -a
elif [ "$platform" = "docker" ]; then
  docker stop nginx-server
  echo docker rm -f nginx-server
  docker rm -f nginx-server
  # echo "running server on port 443"

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    echo stop
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root nginx-server /bin/bash
  echo docker exec -it --user root nginx-server ss --listen
  echo docker logs nginx-server

  if command -v docker-compose; then
    docker compose build
    docker compose up -d
  else
    docker build -t nginx-server .
    docker run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 443:443 -d nginx-server
  fi
fi

exit 0
