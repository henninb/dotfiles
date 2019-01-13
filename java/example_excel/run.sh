#!/bin/sh

gradle wrapper
./gradlew wrapper --gradle-version=5.5.1
./gradlew clean build

docker rm example -f
docker build -t example .
#docker run -it --rm --name my-running-app -d my-running-app
docker run -it --name example -d example
echo docker container prune

exit 0
