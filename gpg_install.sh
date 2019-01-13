#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge gnupg pass
elif [ "$OS" = "Arch Linux" ]; then
  sudo pcaman -S gnupg pass
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y gnupg pass pinentry
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y gnupg pass
elif [ "$OS" = "Mint Linux" ]; then
  sudo apt install -y gnupg pass pinentry-tty
  sudo update-alternatives --config pinentry
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y gnupg sysutils/password-store
else
  echo $OS not configured.
  exit 1
fi

cat > gpg-agent.conf <<'EOF'
pinentry-program /usr/bin/pinentry-curses
allow-loopback-pinentry
EOF

mkdir -p $HOME/.gnupg
chmod 700 $HOME/.gnupg
echo Files inside .gnupg should be chmod 600
echo
echo gpg --full-generate-key

if [ ! -f ~/private.key ]; then
  echo ~/private.key is not found.
  exit 1
fi

echo gpg --batch --import private.key
gpg --batch --import private.key

gpg --edit-key 'henninb@gmail.com' trust quit
# enter 5<RETURN>
# enter y<RETURN>

echo gpg --list-keys
gpg --list-keys

echo gpg --list-secret-keys
gpg --list-secret-keys

gpg --list-keys --fingerprint --with-colons

echo pass init henninb@gmail.com
pass init henninb@gmail.com

echo pass git init
echo pass insert gmail.com/henninb
echo pass insert gmail.com/henninb08

echo foo | tee /tmp/test && gpg -r 'henninb@gmail.com' -e /tmp/test
gpg -d /tmp/test.gpg

gpgconf --kill gpg-agent
ps -ef| grep gpg-agent | grep -v grep
gpg-connect-agent reloadagent /bye

exit 0

gpg -e -u "Sender User Name" -r "Receiver User Name" somefile
gpg --batch --yes --passphrase-fd 0 /tmp/test.gpg
stty -echo; gpg --passphrase-fd 0 --pinentry-mode loopback --decrypt /tmp/test.gpg; stty echo
gpg --passphrase-fd 0 --pinentry-mode loopback -d /tmp/test.gpg

export GPG_TTY=$(tty)
