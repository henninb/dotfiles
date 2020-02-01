#!/usr/bin/env bash

if [ "$OSTYPE" = "linux-gnu" ]; then
  export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
else
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
fi

export PATH=${JAVA_HOME}/bin:${PATH}

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
export PATH=${JAVA_HOME}/bin:${PATH}

touch env.secrets
touch env.console

set -a
. ./env.console
. ./env.secrets
set +a

./gradlew clean build bootRun

exit 0
