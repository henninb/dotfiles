#!/usr/bin/env bash

if [ "$OSTYPE" = "linux-gnu" ]; then
#  export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
  export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)) || readlink $(which javac))))
else
  # macos
  export JAVA_HOME=$(/usr/libexec/java_home)
  #export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
fi

export PATH=${JAVA_HOME}/bin:${PATH}

touch env.secrets
touch env.console

set -a
. ./env.console
. ./env.secrets
set +a

./gradlew clean build bootRun

exit 0
