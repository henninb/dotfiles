#!/bin/sh


if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  echo "gentoo"
  if ! command -v rsync; then
    sudo emerge --update --newuse zsh
  fi
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

files=$(ssh  raspi "ls -d1 /home/pi/downloads/backup-*")
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
