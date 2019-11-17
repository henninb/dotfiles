# git commands

## rebase with the intent to edit commits
git rebase -i --root
git commit --amend --author="Brian Henning <henninb@msn.com>" --no-edit &&  git rebase --continue

## list ignored files
git status --porcelain --ignored

## git rebase edit
git rebase --edit-todo

## git log
git log
git log --online
git log --graph --oneline --all
git log --name-only
