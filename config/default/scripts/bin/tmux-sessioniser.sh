#!/bin/bash

# Originally github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessionizer,
# with adjustments to fit my workflow.

# Get the path.
if [[ $# -eq 1 ]]; then
  selected_path=$1
else
  workspaces=($TMUX_WS) # space delimited string to array
  find_cmd="find ${workspaces[@]} -mindepth 1 -maxdepth 1 -type d"
  selected_path=$(bash -c "$find_cmd | fzf --no-height --tac")
fi

# Get the dir name.
tmux_running=$(pgrep tmux)
selected_dir=$(basename "${selected_path}")

# Get the current session name.
cur_session_name=$(tmux display-message -p '#S')

# Create the new session on demand.
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_dir -c $selected_path
    exit 0
fi

if ! tmux has-session -t=$selected_dir 2> /dev/null; then
    tmux new-session -ds $selected_dir -c $selected_path
fi

# Switch to the new session.
tmux switch-client -t $selected_dir

# Delete current session if it was not created with a project.
num_pattern='^[0-9]+$'
if ! [[ $cur_session_name =~ $num_pattern ]] ; then
  tmux kill-window
else
  tmux kill-session -t $cur_session_name
fi
