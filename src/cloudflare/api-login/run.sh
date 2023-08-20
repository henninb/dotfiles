#!/bin/sh

# miniflare
# wrangler publish
wrangler deploy src/index.ts
echo wrangler dev src/index.ts

exit 0
