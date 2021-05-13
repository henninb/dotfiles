#!/bin/sh

tmux -2 new-session -d -s Main
tmux rename-window -t Main network
# tmux new-window -t Main -n bitchX
tmux new-window -t Main -n mutt
tmux new-window -t Main -n monitor

# network #
tmux split-window -t Main:0 -v -p 78
tmux split-window -t Main:0.1 -v -p 10
tmux split-window -t Main:0.2 -h -p 40

# tmux send-keys -t Main:0.0 "while true; do sleep 3; screen sleep 1 nmtui; done" Enter
# tmux send-keys -t Main:0.1 "while true; do sleep 1; screen sleep 1; /home/coke/.xmonad/waitcon.sh 9; done" Enter
# tmux send-keys -t Main:0.2 "while true; do sleep 1; /home/coke/.xmonad/waitcon.sh 10; done" Enter
# tmux send-keys -t Main:0.3 "while true; do sleep 1; /home/coke/.xmonad/whomonitor.sh; done" Enter

# bitchX #
tmux split-window -t Main:1 -v -p 90
tmux send-keys -t Main:1.0 "whoami" Enter
tmux send-keys -t Main:1.1 "pwd" Enter

# mutt #
tmux send-keys -t Main:2.0 "mutt" Enter

# monitor #
tmux split-window -t Main:3 -v -p 90
tmux send-keys -t Main:3.0 "last" Enter
tmux send-keys -t Main:3.1 "htop" Enter
tmux select-pane -t Main:3.1

tmux -2 attach-session -t Main

exit 0
