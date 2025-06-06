#!/bin/bash

# Kill any existing tmux session with the same name
tmux kill-session -t dvc 2>/dev/null

# Create a new tmux session
tmux new-session -d -s dvc

# Create and setup main window with venv
tmux send-keys "source venv/bin/activate" C-m
tmux send-keys "clear" C-m

# Create R window
tmux new-window -t dvc:1 -n 'R'
tmux send-keys "R" C-m

# Create Python window
tmux new-window -t dvc:2 -n 'Python'
tmux send-keys "source venv/bin/activate" C-m
tmux send-keys "python3" C-m

# Select the first window
tmux select-window -t dvc:0

# Attach to the session
tmux attach-session -t dvc 