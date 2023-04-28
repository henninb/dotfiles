#!/bin/sh


if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S rsync
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v rsync; then
    sudo emerge --update --newuse rsync
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y rsync
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

files=$(ssh  raspi "ls -d1 /home/pi/downloads/backups/backup-*")
# files=$(ssh  raspi "ls -d1 /home/pi/tmp/test/backup-*")

# rsync -arv "raspi:/home/pi/test/" "$HOME/test/"
# echo    "    --update, -u This  forces rsync to skip any files which exist on the destination and have a modified time that is newer than the source file."

# exit 1
include=""
for file in $files; do
  base_file=$(basename $file)
  # echo " --include=$base_file"
  # include="$include --include=\"$base_file/*\""
  # echo rsync -arvz --quiet "raspi:/home/pi/downloads/$base_file/" "$HOME/files/$base_file/"
  # rsync -arvz "raspi:/home/pi/downloads/$base_file/" "$HOME/files/$base_file/"
done
echo "$include"

echo "rsync -arvz --dry-run raspi:/home/pi/downloads/backups/ $HOME/files/"
rsync -arvz raspi:/home/pi/downloads/backups/ "$HOME/files/"
# rsync -arvz --include="backup-d1/*" --include="backup-d2/*" --include="backup-d3/*"  --dry-run --exclude='*' raspi:/home/pi/tmp/test/ "$HOME/tmp/"

exit 0
# vim: set ft=sh:
