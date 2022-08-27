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
