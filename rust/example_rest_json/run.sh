#!/bin/sh

docker rm example_rest_json -f
docker build -t example_rest_json .
#docker run -it --rm --name example_rest_json -d example_rest_json
docker run -it --name example_rest_json -d example_rest_json

exit 0
