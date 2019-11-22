#!/bin/sh

for i in $(find .  -mindepth 1 -maxdepth 1 -type d); do
  ./gradlew wrapper --gradle-version 6.0 --distribution-type all
done

exit 0
