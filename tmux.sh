#! /usr/bin/bash

# Name of the tmux session
SESSION_NAME_1="dev"
SESSION_NAME_2="db"
SESSION_NAME_3="test"

# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_1

# Split the window into two panes
tmux split-window -v -t $SESSION_NAME_1:0

# Run Vim in the first pane
tmux send-keys -t $SESSION_NAME_1:0.0 'bash' C-m

# Run a Bash shell in the second pane
tmux send-keys -t $SESSION_NAME_1:0.1 'vim todo.rb' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_1


# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_2

# Run bash the first pane
tmux send-keys -t $SESSION_NAME_2:0.0 'bash' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_2
