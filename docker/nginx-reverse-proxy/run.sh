#!/bin/sh

docker build -t nginx-reverse-proxy .
docker stop nginx-reverse-proxy
docker rm nginx-reverse-proxy -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-reverse-proxy -h nginx-reverse-proxy -p 8080:80 nginx-reverse-proxy
docker run --name=nginx-reverse-proxy -h nginx-reverse-proxy -h nginx-reverse-proxy --restart unless-stopped -p 8080:80 -d nginx-reverse-proxy
echo running server on port 8080
echo docker exec -it --user root nginx-reverse-proxy /bin/bash
echo docker logs nginx-reverse-proxy

exit 0
