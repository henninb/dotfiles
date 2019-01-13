#!/bin/sh

gradle wrapper
./gradlew wrapper --gradle-version=5.5.1
./gradlew clean build
mkdir -p libs
echo oracle

docker rm example_db -f
docker build -t example_db .
#docker run -it --rm --name my-running-app -d my-running-app
docker run -it --name example_db -d example_db
echo docker container prune

exit 0
