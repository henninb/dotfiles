#!/bin/sh

docker stop nginx-reverse-proxy
docker rm nginx-reverse-proxy -f
docker rmi nginx-reverse-proxy

echo nginx-reverse-proxy running server on port 3001, 3002, 3003, 3004, 3005, 3006
echo docker exec -it --user root nginx-reverse-proxy /bin/bash
echo docker logs nginx-reverse-proxy

if command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-reverse-proxy .
  docker run --name=nginx-reverse-proxy -h nginx-reverse-proxy -h nginx-reverse-proxy --restart unless-stopped -p 8401:8401 -p 8403:8403 -p 8405:8405 -p 8406:8406 -p 8410:8410 -d nginx-reverse-proxy
fi

exit 0
