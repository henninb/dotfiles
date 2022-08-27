#!/bin/sh

docker volume create portainer-data

docker stop portainer
docker rm portainer -f
docker rmi portainer

docker run -d -p 8000:8000 -p 6443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer-data:/data \
    portainer/portainer-ce

exit 0
