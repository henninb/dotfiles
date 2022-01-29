#!/bin/sh

echo npm install @cloudflare/wrangler
wrangler generate cf-example
echo wrangler preview watch
echo wrangler publish
echo wrangler config

exit 0
