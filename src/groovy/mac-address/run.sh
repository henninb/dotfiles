#!/bin/sh

if [ -x "$(command -v groovysh)" ]; then
  # groovysh -d mac-address.groovy
  groovysh mac-address.groovy
else
  echo sdk install groovy 3.0.9
fi

exit 0
