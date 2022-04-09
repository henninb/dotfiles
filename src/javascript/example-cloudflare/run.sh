#!/bin/sh

echo npm install @cloudflare/wrangler
echo wrangler generate cf-example
echo wrangler config
wrangler preview watch
# wrangler publish

exit 0
