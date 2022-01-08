#!/bin/sh

cp "$HOME/.ssh/id_rsa" .
cp "$HOME/.ssh/known_hosts" .

docker stop voidbox
docker rm voidbox -f

if ! docker build -t voidbox .; then
  echo  "failed docker build"
fi

podman stop voidbox
podman rm voidbox -f
podman build --tag voidbox -f ./Dockerfile

rm -rf id_rsa
#sudo sudo docker images
#sudo docker run -dit --name voidbox -h voidbox void/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name voidbox -h voidbox voidbox

docker run -dit --name voidbox -h voidbox voidbox
docker exec -it --user henninb voidbox /bin/bash

exit 0
