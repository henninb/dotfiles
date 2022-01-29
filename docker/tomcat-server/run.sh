#!/bin/sh

docker stop tomcat-server
docker rm tomcat-server -f

if ! docker build -t tomcat-server .; then
  echo  "failed docker build"
fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

docker run -dit --name tomcat-server -p 8080:8080 -h tomcat-server tomcat-server
#docker exec -it --user henninb tomcat-server /bin/bash
docker exec -it tomcat-server /bin/bash

exit 0
