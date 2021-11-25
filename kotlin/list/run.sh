#!/bin/sh

if [ -x "$(command -v kotlinc)" ]; then
  cat list.kt
  kotlinc
else
  echo install kotlin
fi

exit 0
