#!/bin/sh

if command -v tmux; then
  tmux new -s foo
  tmux split-window -t foo.1
  tmux split-window -t foo.1
  tmux split-window -t foo.1
  tmux split-window -t foo.1
  tmux select-layout -t foo main-vertical
  tmux send -t foo.2 "ssh pi" ENTER
  tmux send -t foo.3 "ssh pi" ENTER
  tmux send -t foo.4 "ssh pi" ENTER
  tmux set-window synchronize-pane on
fi

exit 0

# vim: set ft=sh
