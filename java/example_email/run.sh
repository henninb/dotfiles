#!/bin/sh

gradle wrapper
./gradlew wrapper --gradle-version=5.5.1
./gradlew clean build

docker rm example_email -f
docker build -t example_email .
#docker run -it --rm --name my-running-app -d my-running-app
docker run -it --name example_email -d example_email
echo docker container prune

exit 0
