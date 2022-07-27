#!/bin/sh


docker build -t nginx-inject-js .
docker stop nginx-inject-js
docker rm nginx-inject-js -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-inject-js -h nginx-inject-js -p 8080:80 nginx-inject-js
docker run --name=nginx-inject-js -h nginx-inject-js -h nginx-inject-js --restart unless-stopped -p 443:443 -d nginx-inject-js
echo nginx-inject-js running server on port 443
echo docker exec -it --user root nginx-inject-js /bin/bash
echo docker logs nginx-inject-js

exit 0
