#!/bin/sh

if [ -x "$(command -v groovysh)" ]; then
  groovysh next-oncall.groovy 2> /dev/null
else
  echo sdk install groovy 3.0.9
fi

exit 0
