#!/bin/sh

cat <<  EOF > "$HOME/.local/bin/reddit-electron"
#!/bin/sh

PATH="$HOME/electron/reddit-linux-x64:$PATH"
reddit

exit 0
EOF

cat <<  EOF > "$HOME/.local/bin/github-electron"
#!/bin/sh

PATH="$HOME/electron/github-linux-x64:$PATH"
github

exit 0
EOF

chmod 755 "$HOME/.local/bin/reddit-electron"
chmod 755 "$HOME/.local/bin/github-electron"

mkdir -p "$HOME/electron"

cd "$HOME/electron" || exit
npm install nativefier -g

nativefier --name "reddit" "reddit.com"
nativefier --name "github" "github.com"

exit 0

# vim: set ft=sh:
