#!/bin/sh

APP=example_json
HOST_BASEDIR=$(pwd)
GUEST_BASEDIR=/opt/$APP
echo dnf install java-1.8.0-openjdk-devel
./gradlew clean build
mkdir -p logs
touch env.secrets

docker rm $APP -f
docker build -t $APP .
#docker run -it --name $APP --env-file env --env-file env.secrets --rm -d $APP
docker run --name $APP --env-file env --env-file env.secrets -v $HOST_BASEDIR/logs:$GUEST_BASEDIR/logs --rm -t $APP

echo docker container prune

exit 0
