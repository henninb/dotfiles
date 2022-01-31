#!/bin/sh

echo npm install @cloudflare/wrangler
echo wrangler generate cf-example
echo wrangler preview watch
echo wrangler config
echo wrangler publish

exit 0
