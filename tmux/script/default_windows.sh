# USAGE:
# sh default_windows.sh <SESSION> <dir> <vim_dir>
if [ -z "$1" ]
then
    echo Value SESSION not set
    exit 1
fi
if [ -z "$2" ]
then
    echo Value dir not set
    exit 1
fi
if [ -z "$3" ]
then
    echo Value vim_dir not set
    exit 1
fi

WINDOW_VIM=1
WINDOW_TIG=9
WINDOW_GIT=10

# Vim
tmux new-window -t $1:$WINDOW_VIM -n 'vim'
tmux send-keys -t $WINDOW_VIM "cd $3" C-m "ranger" C-m

# Git
tmux new-window -t $1:$WINDOW_GIT -n 'git'
tmux send-keys -t $WINDOW_GIT "cd $2" C-m
tmux send-keys -t $WINDOW_GIT "clear" C-m
tmux send-keys -t $WINDOW_GIT "git status" C-m

# Tig
tmux new-window -t $1:$WINDOW_TIG -n 'tig'
tmux send-keys -t $WINDOW_TIG "cd $2" C-m
tmux send-keys -t $WINDOW_TIG "clear" C-m
tmux send-keys -t $WINDOW_TIG "tig --all" C-m
