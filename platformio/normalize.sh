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
done

exit 0
