mkdir -p "$HOME/keepass-git"
pwd
cd "$HOME/keepass-git" || exit
git init .
pwd
git remote add origin pi:/home/pi/downloads/keepass-git
git fetch
git merge origin/main
