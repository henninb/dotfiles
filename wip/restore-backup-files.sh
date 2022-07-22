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

# rsync -arv "raspi:/home/pi/test/" "$HOME/test/"
# echo    "    --update, -u This  forces rsync to skip any files which exist on the destination and have a modified time that is newer than the source file."

# exit 1

for file in $files; do
  base_file=$(basename $file)
  echo $base_file
  # scp -r "raspi:/home/pi/downloads/$base_file/" "$HOME/files/$base_file/"
  rsync -arv "raspi:/home/pi/downloads/$base_file/" "$HOME/files/$base_file/"
done

exit 0
