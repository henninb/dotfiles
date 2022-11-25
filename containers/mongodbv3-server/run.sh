#!/bin/sh

docker stop mongodb-server
docker rm mongodb-server -f

# if ! docker build -t mongodb-server .; then
#   echo  "failed docker build"
# fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

# docker run -dit --name mongodb-server -p 27017:27017 -h mongodb-server mongodb-server
docker run -dit \
    -p 27017:27017 \
    --name mongodb-server \
    -h mongodb-server \
    mongo:3.6
echo docker exec -it mongodb-server /bin/bash
echo docker logs mongodb-server --follow

exit 0
# -v data-vol:/data/db \
