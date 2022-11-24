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
  if command -v podman; then
    podman stop voidbox
    podman rm voidbox -f
    podman build --tag voidbox -f ./Dockerfile
    podman run -dit --name voidbox -h voidbox voidbox
    podman exec -it --user henninb voidbox /bin/bash
  else
    echo "install podman"
  fi
elif [ "$platform" = "docker" ]; then
  docker stop voidbox
  docker rm voidbox -f
  if ! docker build -t voidbox .; then
    echo  "failed docker build"
  fi
  docker run -dit --name voidbox -h voidbox voidbox
  docker exec -it --user henninb voidbox /bin/bash
fi

rm -rf id_rsa
rm -rf known_hosts

exit 0
