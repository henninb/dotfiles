#!/bin/sh

APP=rest-with-json
TIMEZONE='America/Chicago'
USERNAME=henninb

touch env
touch env.secrets

cargo build --release
docker rm ${APP} -f
docker build -t $APP --build-arg TIMEZONE=${TIMEZONE} --build-arg APP=${APP} --build-arg USERNAME=${USERNAME} .
if [ $? -ne 0 ]; then
  echo "docker build failed."
  exit 1
fi

#docker run -it --rm --name ${APP} -d ${APP}
docker run -it -h ${APP} -p 8081:8080 --env-file env.secrets --env-file env --rm --name ${APP} ${APP}

exit 0
