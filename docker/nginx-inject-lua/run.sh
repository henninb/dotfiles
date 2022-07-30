#!/bin/sh


docker stop nginx-inject-lua
docker rm nginx-inject-lua -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-inject-lua -h nginx-inject-lua -p 8080:80 nginx-inject-lua
# docker build -t nginx-inject-lua .
# docker run --name=nginx-inject-lua -h nginx-inject-lua -h nginx-inject-lua --restart unless-stopped -p 80:80 -p 443:443 -d nginx-inject-lua
echo nginx-inject-lua running server on port 443
echo docker exec -it --user root nginx-inject-lua /bin/bash
echo docker exec -it --user root nginx-inject-lua ss --listen
echo docker logs nginx-inject-lua

if command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-inject-lua .
  docker run --name=nginx-inject-lua -h nginx-inject-lua -h nginx-inject-lua --restart unless-stopped -p 80:80 -p 443:443 -d nginx-inject-lua
fi

exit 0
