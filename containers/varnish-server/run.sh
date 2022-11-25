#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  if command -v podman; then
    podman stop varnish-server
    podman rm varnish-server -f
    podman-compose up -d
  else
    echo "install podman"
  fi
elif [ "$platform" = "docker" ]; then
  docker stop varnish-server
  docker rm varnish-server -f
  docker compose up -d
fi

sleep 3
echo curl -I localhost:8484
curl -I localhost:8484

exit 0
