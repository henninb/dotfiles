#!/bin/sh

echo markdown filename change
for f in *.md; do git mv "$f" "$(echo "$f" | sed s/_/-/)"; done

exit 0

# can be changed
