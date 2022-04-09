#!/bin/sh

echo npx create-next-app example-nextjs
echo 'http://localhost:3000/hello'
echo 'http://localhost:3000/cars'
pnpm install
pnpm run dev

exit 0
