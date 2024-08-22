#! /usr/bin/bash

# Name of the tmux session
SESSION_NAME_1="controller"
SESSION_NAME_2="model"
SESSION_NAME_3="views"
SESSION_NAME_4="db"
SESSION_NAME_5="test"

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
tmux send-keys -t $SESSION_NAME_2:0.0 'vim lib/database_persistence.rb' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_2



# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_3

# Run bash in the first pane
tmux send-keys -t $SESSION_NAME_3:0.0 'vim views/layout.erb' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_3



# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_4

# Run bash in the first pane
tmux send-keys -t $SESSION_NAME_4:0.0 'bash' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_4



# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_5

# Run bash in the first pane
tmux send-keys -t $SESSION_NAME_5:0.0 'bash' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_5



