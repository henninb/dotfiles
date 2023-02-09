#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1
port=443

if [ "$platform" = "podman" ]; then
  podman stop apache-server
  podman rm -f apache-server
  echo "running server on port 443"
  blocking=$(podman ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    podman stop "${blocking}"
    podman rm -f "${blocking}"
  fi

  echo podman exec -it --user root apache-server /bin/sh
  echo podman logs apache-server

  podman-compose build
  podman-compose up -d
  curl -I https://localhost:443/
elif [ "$platform" = "docker" ]; then
  docker stop apache-server
  docker rm -f apache-server
  echo "running server on port 443"
  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root apache-server /bin/sh
  echo docker logs apache-server --follow

  if command -v docker-compose; then
    docker-compose build
    docker-compose up -d
    curl -Ik https://localhost:443/
  else
    docker build -t apache-server .
    echo 'docker run --name=apache-server -h apache-server -h apache-server --restart unless-stopped -p 443:443 -d apache-server'
  fi
fi

exit 0
