mkdir -p "$HOME/keepass-git"
cd "$HOME/keepass-git" || exit
git remote add origin pi:/home/pi/downloads/keepass-git
git fetch
git merge origin/main
