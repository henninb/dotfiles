#!/bin/sh

docker build -t nginx-server .
docker stop nginx-server
docker rm nginx-server -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-server -h nginx-server -p 8080:80 nginx-server
docker run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 8080:80 -d nginx-server
echo running server on port 8080
docker exec -it --user root nginx-server /bin/bash

exit 0
