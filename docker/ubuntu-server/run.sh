#!/bin/sh

cp -v "$HOME/.ssh/id_rsa" .
cp -v "$HOME/.ssh/known_hosts" .

docker stop ubuntu-server
docker rm ubuntu-server -f

if ! docker build -t ubuntu-server .; then
  echo  "failed docker build"
fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

if ! command -v podman; then
  podman stop ubuntu-server
  podman rm ubuntu-server -f
  podman build --tag ubuntu-server -f ./Dockerfile
fi
# podman run -dit --name ubuntu-server -h ubuntu-server ubuntu-server
# podman exec -it --user henninb ubuntu-server /bin/bash

rm -rf id_rsa
docker run -dit --name ubuntu-server -h ubuntu-server ubuntu-server
docker exec -it --user henninb ubuntu-server /bin/bash

exit 0
