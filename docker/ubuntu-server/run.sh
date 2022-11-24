#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

cp -v "$HOME/.ssh/id_rsa" .
cp -v "$HOME/.ssh/known_hosts" .


# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi
if [ "$platform" = "podman" ]; then
  if ! command -v podman; then
    podman stop ubuntu-server
    podman rm ubuntu-server -f
    podman build --tag ubuntu-server -f ./Dockerfile
    podman run -dit --name ubuntu-server -h ubuntu-server ubuntu-server
    podman exec -it --user henninb ubuntu-server /bin/bash
  else
    echo "install podman"
  fi
elif [ "$platform" = "docker" ]; then
  docker stop ubuntu-server
  docker rm ubuntu-server -f
  if ! docker build -t ubuntu-server .; then
    echo  "failed docker build"
  fi
  docker run -dit --name ubuntu-server -h ubuntu-server ubuntu-server
  docker exec -it --user henninb ubuntu-server /bin/bash
fi


rm -rf id_rsa

exit 0
