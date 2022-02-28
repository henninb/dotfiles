#!/bin/sh

if [ ! -x "$(command -v serve)" ]; then
  npm i -g serve
fi

serve

exit 0
