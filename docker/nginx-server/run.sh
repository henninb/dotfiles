#!/bin/sh

docker build -t nginx-server .
docker stop nginx-server
docker rm nginx-server -f

docker run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 443:443 -d nginx-server
echo running server on port 443
echo docker exec -it --user root nginx-server /bin/bash
echo docker logs nginx-server

exit 0
