#!/bin/sh

docker build -t nginx-reverse-proxy .
docker stop nginx-reverse-proxy
docker rm nginx-reverse-proxy -f

echo nginx-reverse-proxy running server on port 3001, 3002, 3003
echo docker exec -it --user root nginx-reverse-proxy /bin/bash
echo docker logs nginx-reverse-proxy

if command -v docker-compose; then
  docker-compose up
else
  docker run --name=nginx-reverse-proxy -h nginx-reverse-proxy -h nginx-reverse-proxy --restart unless-stopped -p 3003:3003 -p 3001:3001 -p 3002:3002 -p 3004:3004 -d nginx-reverse-proxy
fi

exit 0
