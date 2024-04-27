# git commands

## rebase with the intent to edit commits
```shell
$ git rebase -i --root
$ git commit --amend --author="Brian Henning <henninb@msn.com>" --no-edit &&  git rebase --continue
```

## list ignored files
```shell
$ git status --porcelain --ignored
```

## git rebase edit
```shell
$ git rebase --edit-todo
```

## git log
```shell
$ git log
$ git log --oneline
$ git log --oneline --graph --all
$ git log --name-only
```

## git set remote
```shell
$ git push --set-upstream origin master
```

## git set email for local
```shell
$ git config --local  user.email henninb@msn.com
```

## git add tags
```shell
$ git tag -a v0.0.1 -m "first travis build"
$ git push origin v0.0.1
```

## git password
```shell
$ vi .git/config
[filter "pw"]
  clean = "sed -e 's/sasl_password = .*;/identify <PASSWORD>\";/'"

$ vi .git/info/attributes
config filter=pw
```

## git list settings
```shell
$ git config --list
```

## git encript on commit
```
[filter "crypt"]
	clean = openssl enc ...
	smudge = openssl enc -d ...
	required
```

## git issue found
```
https://github.com/ohmyzsh/ohmyzsh/commit/8f33231823dbf6c68ccc65fbb028fce6ff1efd74
```

## git remove stash
```
git stash drop <stash_id>
```

## remote git repo on my local network
git remote add origin pi:/home/pi/downloads/keepass-git
