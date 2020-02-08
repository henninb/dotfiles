#!/bin/sh

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin

exit 0
