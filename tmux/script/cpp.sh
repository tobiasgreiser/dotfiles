#!/bin/bash
SESSION="dc"

WINDOW_COMPILE=2
WINDOW_GAZEBO=3
WINDOW_ZULIP=8

tmux_script_dir="/home/ubuntu/tmux"
dir="kitcar/kitcar-gazebo-simulation"

alias tmux="tmux -f ~/dotfiles/tmux/tmux.conf"
tmux -2 new-session -d -s $SESSION

sh $tmux_script_dir/default_windows.sh $SESSION $dir $dir/simulation

# Compile
tmux new-window -t $SESSION:$WINDOW_COMPILE -n 'compile'
tmux send-keys -t $WINDOW_COMPILE "cd $dir/simulation" C-m "ranger" C-m
tmux send-keys -t $WINDOW_COMPILE "clear" C-m
tmux send-keys -t $WINDOW_COMPILE "catkin_make"

# Gazebo
tmux new-window -t $SESSION:$WINDOW_GAZEBO -n 'gazebo'
tmux send-keys -t $WINDOW_GAZEBO "roslaunch gazebo_simulation master.launch"

# Zulip
tmux new-window -t $SESSION:$WINDOW_ZULIP -n 'zulip'
tmux send-keys -t $WINDOW_ZULIP "cd ~/zulip/" C-m
tmux send-keys -t $WINDOW_ZULIP "source zulip-terminal-venv/bin/activate" C-m
tmux send-keys -t $WINDOW_ZULIP "zulip-term -c zuliprc" C-m

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
