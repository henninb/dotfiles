#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  if ! command -v gpg; then
    doas emerge --update --newuse gnupg
  fi
  doas emerge --update --newuse pass
elif [ "$OS" = "Linux Mint" ]; then
  doas apt install -y gnupg
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S gnupg
  doas pacman --noconfirm --needed -S pass
  yay -S kpcli
  yay -S pass-import
elif [ "$OS" = "CentOS Linux" ]; then
  doas yum install -y gnupg pass pinentry
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y gnupg pass
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux"  ]; then
  doas apt install -y gnupg pass pinentry-tty
  doas update-alternatives --config pinentry
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y gnupg sysutils/password-store pinentry-curses
  # sudo ln -sfn /usr/bin/pinentry-curses  /usr/local/bin/pinentry-curses
  doas ln -sfn /usr/local/bin/pinentry-curses  /usr/bin/pinentry-curses
else
  echo "$OS not configured."
  exit 1
fi

# git clone https://github.com/davidnemec/bitwarden-to-keepass ~/projects/bitwarden-to-keepass
git clone https://github.com/roddhjav/pass-import ~/projects/pass-import
ls -l ~/.local/share/password-store

# cat > gpg-agent.conf <<'EOF'
# pinentry-program /usr/bin/pinentry-curses
# allow-loopback-pinentry
# EOF

# mkdir -p $HOME/.gnupg
# chmod 700 $HOME/.gnupg

echo
echo gpg --full-generate-key

echo "gpg --batch --import $HOME/files/backup-pgp/private.key"
gpg --batch --import "$HOME/files/backup-pgp/private.key"

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
pgrep gpg-agent
gpg-connect-agent reloadagent /bye

# scp -r "pi:/home/pi/.local/share/password-store/*" .local/share/password-store/
# scp -r * pi:/home/pi/.local/share/password-store/
# gpg -e -u "Sender User Name" -r "Receiver User Name" somefile
# gpg --batch --yes --passphrase-fd 0 /tmp/test.gpg
# stty -echo; gpg --passphrase-fd 0 --pinentry-mode loopback --decrypt /tmp/test.gpg; stty echo
# gpg --passphrase-fd 0 --pinentry-mode loopback -d /tmp/test.gpg
# export GPG_TTY=$(tty)

exit 0

# vim: set ft=sh:
