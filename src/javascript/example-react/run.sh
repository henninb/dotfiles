#!/bin/sh

# mkdir -p src/data
# wget https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild -O src/data/wild-schedule.json
echo npx create-react-app react-app
npm install

npm run build
docker stop example-react
docker rm -f example-react
docker rmi example-react
docker compose -f docker-compose.yml up -d
echo npm start

exit 0
