#!/bin/sh


docker stop nginx-server-multi
docker rm nginx-server-multi -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-server-multi -h nginx-server-multi -p 8080:80 nginx-server-multi
echo nginx-server-multi running server on port 443
echo docker exec -it --user root nginx-server-multi /bin/bash
echo docker logs nginx-server-multi
if command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker build -t nginx-server-multi .
  docker run --name=nginx-server-multi -h nginx-server-multi -h nginx-server-multi --restart unless-stopped -p 443:443 -d nginx-server-multi
fi

exit 0
