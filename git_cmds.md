# git commands

## rebase with the intent to edit commits
```shell
git rebase -i --root
git commit --amend --author="Brian Henning <henninb@msn.com>" --no-edit &&  git rebase --continue
```

## list ignored files
```shell
git status --porcelain --ignored
```

## git rebase edit
```shell
git rebase --edit-todo
```

## git log
```shell
git log
git log --oneline
git log --oneline --graph --all
git log --name-only
```

## git set remote
```shell
git push --set-upstream origin master
```

## git set email for local
```shell
git config --local  user.email henninb@msn.com
```
