#!/bin/sh

mkdir -p data
docker volume create portainer-data

docker run -d -p 8000:8000 -p 6443:6443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer-data:/data \
    portainer/portainer-ce

exit 0
