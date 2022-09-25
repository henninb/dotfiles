#!/bin/sh

cat > src/config.h <<EOF
#define uploadTimestamp ""
EOF

make

exit 0
