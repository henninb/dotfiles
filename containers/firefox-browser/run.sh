#!/bin/sh

cp "$HOME/.ssh/id_rsa" .
cp "$HOME/.ssh/known_hosts" .

docker stop firefox-server
docker rm firefox-server -f

# if ! docker build -t firefox-server .; then
  # echo  "failed docker build"
# fi

if ! docker-compose up -d; then
  echo "failed docker-compose"
fi

# docker run -dit --name firefox-server -h firefox-server firefox-server
# docker exec -it --user henninb firefox-server /bin/bash

exit 0
