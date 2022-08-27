#!/bin/sh

docker stop nginx-server-hosted
docker rm -f nginx-server-hosted

echo running server on port 443
echo docker exec -it --user root nginx-server-hosted /bin/bash
echo docker exec -it --user root nginx-server-hosted ss --listen
echo docker logs nginx-server-hosted
echo docker network create --driver bridge isolated

docker network ls

if command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-server-hosted .
  docker run --network-mode host --name=nginx-server-hosted -h nginx-server-hosted -h nginx-server-hosted --restart always -d nginx-server-hosted
fi

exit 0
