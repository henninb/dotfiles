#!/bin/sh

for i in $(find .  -mindepth 1 -maxdepth 1 -type d); do
  cd $i
  ./gradlew wrapper --gradle-version 6.0 --distribution-type all
  cp ../example/run.sh run.sh
  cd -
done

exit 0
