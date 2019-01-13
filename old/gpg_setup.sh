#!/bin/sh

echo https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
echo https://stackoverflow.com/questions/17769831/how-to-make-gpg-prompt-for-passphrase-on-cli

echo gpg --import private.key
echo gpg --batch --import private.key

echo generate a new key
echo gpg --full-generate-key

echo gpg --edit-key 'henninb@gmail.com' trust quit
# enter 5<RETURN>
# enter y<RETURN>

echo gpg --list-keys
gpg --list-keys

sudo apt install pass

echo pass init henninb@gmail.com
pass init henninb@gmail.com

chmod 700 $HOME/.gnupg
echo Files inside .gnupg should be chmod 600

echo pass git init
echo pass insert gmail.com/henninb
echo pass insert gmail.com/henninb08

echo gpg --list-secret-keys
gpg --list-secret-keys

echo encrypt a file
echo foo > /tmp/test
gpg -e -u "Sender User Name" -r "Receiver User Name" somefile
echo foo | tee /tmp/test && gpg -r 'henninb@gmail.com' -e /tmp/test

echo decrypt a file
gpg -d /tmp/test.gpg

gpg --list-keys --fingerprint --with-colons

gpg --batch --yes --passphrase-fd 0 /tmp/test.gpg

stty -echo; gpg --passphrase-fd 0 --pinentry-mode loopback --decrypt /tmp/test.gpg; stty echo
gpg --passphrase-fd 0 --pinentry-mode loopback -d /tmp/test.gpg
echo disable gui
echo export PINENTRY_USER_DATA="USE_CURSES=1"

cat > gpg-agent.conf <<'EOF'
pinentry-program /usr/bin/pinentry-curses
allow-loopback-pinentry
EOF

gpg-connect-agent reloadagent /bye

echo on debian based systems
sudo apt install pinentry-tty
sudo update-alternatives --config pinentry

ps -ef| grep gpg-agent | grep -v grep
export GPG_TTY=$(tty)

gpgconf --kill gpg-agent

exit 0
