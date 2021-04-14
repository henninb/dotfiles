#!/bin/sh

cat > .gitignore <<EOF
.pio
EOF

projects=$(find . -mindepth 1 -maxdepth 1 -type d)

for project in $projects; do
  echo "$project"
  mkdir -p "$project/test"
  touch "$project/test/.save"
  git add -f "$project/test/.save"
  cp .gitignore "$project"
  git add -f "$project/.gitignore"
  touch "$project/readme.md"
  git add -f "$project/readme.md"
  # echo "date=\$(shell date '+%Y-%m-%d %H:%M:%S')" |cat - "$project/Makefile" > /tmp/out && mv /tmp/out "$project/Makefile"
  cd "$project"
  if make > /dev/null 2>&1; then
    echo "$project - compile success"
  else
    echo "$project - compile failed"
  fi
  cd ..
done

exit 0
