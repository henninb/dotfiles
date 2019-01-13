#!/bin/sh

echo dnf install java-1.8.0-openjdk-devel
gradle wrapper
./gradlew wrapper --gradle-version=5.5.1
./gradlew clean build

docker rm example -f
docker build -t example .
docker run -it --name example -d example
echo docker container prune

exit 0
