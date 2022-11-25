#!/bin/sh


docker stop nginx-inject-js
docker rm nginx-inject-js -f
#sudo sudo docker images

echo nginx-inject-js running server on port 443
echo docker exec -it --user root nginx-inject-js /bin/bash
echo docker exec -it --user root nginx-inject-js ss --listen
echo docker logs nginx-inject-js

if command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-inject-js .
  docker run --name=nginx-inject-js -h nginx-inject-js -h nginx-inject-js --restart unless-stopped -p 443:443 -d nginx-inject-js
fi

exit 0
