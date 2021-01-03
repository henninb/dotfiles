ps -eo pid,etime,comm  | grep node |grep -v grep

echo ':echo fnamemodify(tempname(), ':p:h')'
echo lsof  | grep 'coc-nvim'

nvm install 14.15.3

ps -ef| grep vim

ps -ef| grep git-diff-wrapper
pgrep -f git-diff-wrapper

