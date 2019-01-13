git log
git rebase -i --root
git commit --amend --author="Brian Henning <henninb@msn.com>" --no-edit &&  git rebase --continue

# list ignored files
git status --porcelain --ignored

git log --online
git log --graph --oneline --all
git log --name-only
Merge: 9eac5ce 227ab41
Merge: a5a9f80 2ab172a
