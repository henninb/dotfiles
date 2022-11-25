#!/bin/sh

docker stop python-flask-server
docker rm python-flask-server -f

if ! docker build -t python-flask-server .; then
  echo  "failed docker build"
fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

docker run -dit --name python-flask-server -p 5000:5000 -h python-flask-server python-flask-server
#docker exec -it --user henninb python-flask-server /bin/bash
echo 'http://localhost:5000/'
docker exec -it python-flask-server /bin/bash

exit 0
