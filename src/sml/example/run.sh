#!/bin/sh


APP=example

docker rm $APP -f
docker build -t $APP .
mkdir -p logs
touch env.secrets

docker run --name $APP --env-file env --env-file env.secrets -v $HOST_BASEDIR/logs:$GUEST_BASEDIR/logs --rm -t $APP

exit 0
