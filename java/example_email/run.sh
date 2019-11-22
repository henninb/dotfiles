#!/bin/sh

APP=example_email
echo dnf install java-1.8.0-openjdk-devel
./gradlew clean build

docker rm $APP -f
docker build -t $APP .
#docker run -it --name $APP --env-file env --env-file env.secrets --rm -d $APP
docker run --name $APP --env-file env --env-file env.secrets --rm -t $APP

echo docker container prune

exit 0
