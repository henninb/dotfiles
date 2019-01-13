#!/bin/sh

gradle wrapper
./gradlew wrapper --gradle-version=5.5.1
./gradlew clean build

docker rm example_json -f
docker build -t example_json .
#docker run -it --rm --name my-running-app -d my-running-app
docker run -it --name example_json -d example_json
echo docker container prune

exit 0
