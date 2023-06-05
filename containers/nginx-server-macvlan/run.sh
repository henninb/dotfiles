#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop nginx-server-maclan
  podman rm -f nginx-server-maclan
  echo "running server on port 443"

  podman-compose build
  podman-compose up
  # podman build -t nginx-server-maclan .
  # podman run --name=nginx-server-maclan -h nginx-server-maclan -h nginx-server-maclan --restart unless-stopped -p 443:443 -d nginx-server-maclan
elif [ "$platform" = "docker" ]; then
  docker stop nginx-server-maclan
  docker rm -f nginx-server-maclan
  echo "running server on port 443"

  echo docker exec -it --user root nginx-server-maclan /bin/bash
  echo docker exec -it --user root nginx-server-maclan ss --listen
  echo docker logs nginx-server-maclan

  if command -v docker-compose; then
    docker compose build
    docker compose up
  else
    docker build -t nginx-server-maclan .
    docker run --name=nginx-server-maclan -h nginx-server-maclan -h nginx-server-maclan --restart unless-stopped -p 443:443 -d nginx-server-maclan
  fi
fi

exit 0

#!/bin/sh

docker stop nginx-server-macvlan
docker rm -f nginx-server-macvlan

echo running server on port 443
echo docker exec -it --user root nginx-server-macvlan /bin/bash
echo docker exec -it --user root nginx-server-macvlan ss --listen
echo docker logs nginx-server-macvlan
echo docker network create --driver bridge isolated

docker network ls

if command -v docker-compose1; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-server-macvlan .
  # docker run --net=macvlan-net --name=nginx-server-macvlan -h nginx-server-macvlan -h nginx-server-macvlan --restart always --ip=192.168.10.26 -p 443:443 -d nginx-server-macvlan
  docker run --net=macvlan-net --name=nginx-server-macvlan -h nginx-server-macvlan -h nginx-server-macvlan --restart always -p 443:443 -d nginx-server-macvlan
fi

exit 0
