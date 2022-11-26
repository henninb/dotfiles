#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nginx-inject-js
  podman rm -f nginx-inject-js
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop nginx-inject-js
  docker rm -f nginx-inject-js
  echo "running server on port 443"

  echo docker exec -it --user root nginx-inject-js /bin/bash
  echo docker exec -it --user root nginx-inject-js ss --listen
  echo docker logs nginx-inject-js

  if command -v docker-compose; then
    docker-compose build
    docker-compose up
  else
    docker build -t nginx-inject-js .
    docker run --name=nginx-inject-js -h nginx-inject-js -h nginx-inject-js --restart unless-stopped -p 443:443 -d nginx-inject-js
  fi
fi

exit 0
