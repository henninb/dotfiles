#!/bin/sh

docker rm rest_endpoint -f
docker build -t rest_endpoint .
docker run -it --rm --name rest_endpoint -p 3000:3000 -d rest_endpoint

exit 0

