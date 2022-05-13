#!/bin/sh

echo npx create-next-app example-nextjs
echo 'http://localhost:3000/hello'
echo 'http://localhost:3000/cars'
#npm install
touch .env.local
npm install
npm run dev


exit 0
