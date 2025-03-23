#!/bin/sh

usage() {
  echo "Usage: $0 {local|remote}"
  exit 1
}

# Ensure a single option is provided.
if [ "$#" -ne 1 ]; then
  usage
fi

OPTION=$1

# docker network create my-network
if [ "$OPTION" = "local" ]; then
  echo "=== Building and running container locally ==="

  # (Optional) Run any npm initialization commands if needed:
  # npm init
  # npm install
  # npm start

  docker build -t express-app .
  docker rm -f express-app 2>/dev/null
  docker run --name=express-app \
    -h express-app \
    --network my-network \
    --restart unless-stopped \
    -p 80:3000 \
    -d express-app

  echo "Container running locally. Access at http://localhost"
elif [ "$OPTION" = "remote" ]; then
  echo "=== Building and running container on remote host ==="

  # Add your SSH key for the remote (GCP) host.
  ssh-add ~/.ssh/id_rsa_gcp

  # Create (or update) a Docker context for the remote host.
  docker context create remote-webserver --docker "host=ssh://brianhenning@34.132.189.202"
  export DOCKER_HOST=ssh://gcp-api

  # Switch to the remote context.
  #docker context use remote-webserver

  docker build -t express-app .
  docker rm -f express-app 2>/dev/null
  docker run --name=express-app \
    -h express-app \
    --network my-network \
    --restart unless-stopped \
    -p 80:3000 \
    -d express-app

  echo "Container running on remote host. Access at http://<remote-host-ip>"
else
  usage
fi

gcloud compute firewall-rules create allow-http-port80 \
  --network=default \
  --allow tcp:80 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=bhenning-api \
  --description="Allow incoming HTTP traffic on port 80"

exit 0
