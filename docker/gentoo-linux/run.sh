#!/bin/sh

cp ~/.ssh/id_rsa .
docker build -t gentoobox -f Dockerfile .

rm -rf id_rsa
docker stop gentoobox
docker rm gentoobox -f
docker run -dit --name gentoobox -h gentoobox gentoobox
docker exec -it --user henninb gentoobox /bin/bash

exit 0
