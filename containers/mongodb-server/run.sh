#!/bin/sh

docker stop mongodb-server
docker rm mongodb-server -f
docker rmi mongodb-server

echo docker exec -it --user root mongodb-server /bin/bash
echo docker exec -it --user root mongodb-server tail -f /var/log/nginx/ddwrt-access.log
echo docker logs mongodb-server

if command -v docker-compose; then
  docker-compose build
  docker-compose up -d
else
  docker build -t mongodb-server .
  docker run --name=mongodb-server -h mongodb-server -h mongodb-server --restart always -p 27017:27017 -d mongodb-server
fi

exit 0
