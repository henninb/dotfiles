#!/bin/sh

cat > .gitignore <<EOF
.pio
EOF

log="$(pwd)/compile.$$.log"

projects=$(find . -mindepth 1 -maxdepth 1 -type d | sort)

for project in $projects; do
  echo "$project"
  mkdir -p "$project/test"
  touch "$project/test/.save"
  git add -f "$project/test/.save"
  cp .gitignore "$project"
  git add -f "$project/.gitignore"
  touch "$project/readme.md"
  git add -f "$project/readme.md"
  git add -f "$project/src/main.cpp"
  sed -i "s/main.cpp/config.h/g" "$project/Makefile"
  git add -f "$project/Makefile"

  git add -f "$project/platformio.ini"
  if ! grep -q "#define uploadTimestamp" "$project/src/config.h" 2> /dev/null; then
    echo "#define uploadTimestamp \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define ssid" "$project/src/config.h" 2> /dev/null; then
    echo "#define ssid \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define password" "$project/src/config.h" 2> /dev/null; then
    echo "#define password \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define mqttServer" "$project/src/config.h" 2> /dev/null; then
    echo "#define mqttServer \"\"" >> "$project/src/config.h"
  fi
  # echo "date=\$(shell date '+%Y-%m-%d %H:%M:%S')" |cat - "$project/Makefile" > /tmp/out && mv /tmp/out "$project/Makefile"
  cd "$project" || exit
  if make > /dev/null 2>&1; then
    echo "$project - compile success" | tee -a "${log}"
  else
    echo "$project - compile failed" | tee -a "${log}"
  fi
  cd ..
done

exit 0
