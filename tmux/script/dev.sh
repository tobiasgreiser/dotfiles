#!/bin/bash
SESSION="d"

WINDOW_TESTING=2
WINDOW_ZULIP=8

tmux_script_dir="/home/ubuntu/tmux"
dir="~/kitcar/kitcar-gazebo-simulation"

alias tmux="tmux -f ~/dotfiles/tmux/tmux.conf"
tmux -2 new-session -d -s $SESSION

sh $tmux_script_dir/default_windows.sh $SESSION $dir $dir/simulation

# Testing
tmux new-window -t $SESSION:$WINDOW_TESTING -n 'testing'
tmux send-keys -t $WINDOW_TESTING "cd $dir" C-m
tmux send-keys -t $WINDOW_TESTING "ranger" C-m

# Zulip
tmux new-window -t $SESSION:$WINDOW_ZULIP -n 'zulip'
tmux send-keys -t $WINDOW_ZULIP "cd ~/zulip/" C-m
tmux send-keys -t $WINDOW_ZULIP "source zulip-terminal-venv/bin/activate" C-m
tmux send-keys -t $WINDOW_ZULIP "zulip-term -c zuliprc" C-m

# Set default window
# tmux select-window -t $SESSION:$WINDOW_VIM
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
