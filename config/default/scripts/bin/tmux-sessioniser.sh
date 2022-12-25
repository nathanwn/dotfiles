#!/bin/bash

# Originally github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessioniser,
# with adjustments to fit my workflow.

list_directories_to_lines() {
  directories=($tmux_sessioniser_directories)
  for i in "${directories[@]}"
  do
     echo "$i"
  done
}

export -f list_directories_to_lines

# Get the path.
if [[ $# -eq 2 ]]; then
  selected_path=$1
else
  workspaces=($tmux_sessioniser_workspaces) # space delimited string to array
  find_cmd = "find $HOME/dev -maxdepth 5 -type d -name .git | xargs dirname"
  # selected_path=$(bash -c "($find_cmd && list_directories_to_lines;) | fzf --no-height --tac")
  selected_path=$(bash -c "find $HOME/dev -maxdepth 5 -type d -name .git | xargs dirname | fzf --no-height --tac")
fi

# Get the dir name.
tmux_running=$(pgrep tmux)
selected_dir=$(basename "${selected_path}")

echo "selected_dir: $selected_dir" >> ~/tmux-sessioniser.log
echo "selected_path: $selected_path" >> ~/tmux-sessioniser.log

# Get the current session name.
cur_session_name=$(tmux display-message -p '#S')

# Case 1: tmux is not active.
# Create the new session on demand.
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_dir -c $selected_path
    echo "tmux new-session -s $selected_dir -c $selected_path"
    exit 0
fi

# Case 2: tmux is active, hence create in detach mode then switch.
# Create the new session on demand.
if ! tmux has-session -t=$selected_dir 2> /dev/null; then
    tmux new-session -ds "$selected_dir" -c "$selected_path"
    echo "tmux new-session -ds $selected_dir -c $selected_path" >> ~/tmux-sessioniser.log
fi

# Switch to the new session.
tmux switch-client -t $selected_dir

# Delete current session if it was not created with a project.
num_pattern='^[0-9]+$'
if ! [[ $cur_session_name =~ $num_pattern ]] ; then
  tmux kill-window
  echo "tmux kill-window"  >> ~/tmux-sessioniser.log
else
  tmux kill-session -t $cur_session_name
  echo "tmux kill-session -t $cur_session_name" >> ~/tmux-sessioniser.log
fi
