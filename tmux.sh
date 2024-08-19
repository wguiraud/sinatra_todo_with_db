#! /usr/bin/bash

# Name of the tmux session
SESSION_NAME_1="dev"
SESSION_NAME_2="db"
SESSION_NAME_3="test"

# Check if the session already exists
if tmux has-session -t $SESSION_NAME_1 2>/dev/null; then
  echo "Session $SESSION_NAME_1 already exists. Attaching to it..."
  tmux attach-session -t $SESSION_NAME_1
  exit 0
fi

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


# Check if the session already exists
if tmux has-session -t $SESSION_NAME_2 2>/dev/null; then
  echo "Session $SESSION_NAME_2 already exists. Attaching to it..."
  tmux attach-session -t $SESSION_NAME_2
  exit 1
fi

# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_2

# Run bash the first pane
tmux send-keys -t $SESSION_NAME_2:0.0 'bash' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_2

# Check if the session already exists
if tmux has-session -t $SESSION_NAME_3 2>/dev/null; then
  echo "Session $SESSION_NAME_3 already exists. Attaching to it..."
  tmux attach-session -t $SESSION_NAME_3
  exit 1
fi

# Create a new tmux session
tmux new-session -d -s $SESSION_NAME_3

# Run bash in the first pane
tmux send-keys -t $SESSION_NAME_3:0.0 'bash' C-m

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME_3

