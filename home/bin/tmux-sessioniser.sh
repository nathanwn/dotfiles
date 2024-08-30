#!/bin/bash

set -euo pipefail

# Originally github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessioniser,
# with adjustments to fit my workflow.

if [[ $1 == "repo" ]] ; then
  root_dir="$HOME/dev"

  # Get the path.
  selected_path=$(\
    bash -c "find $root_dir -maxdepth 7 -name .git \
    | xargs dirname \
    | sed 's;$root_dir/;;g' \
    | fzf --no-height --tac"
  )
  # When fzf is interrupted by ctrl+c, it returns an empty string.
  if [[ -z $selected_path ]]; then
    exit 0
  fi
  selected_path="$root_dir/$selected_path"

  # Get the dir name.
  selected_dir=$(basename "${selected_path}")

  echo "selected_dir: $selected_dir" >> ~/tmux-sessioniser.log
  echo "selected_path: $selected_path" >> ~/tmux-sessioniser.log

  # Get the current session name.
  cur_session_name=$(tmux display-message -p '#S')
  # Use tr to convert '.' to '_' for session name as tmux session name cannot take '.'
  session_name=$(realpath -s --relative-to="$root_dir" "$selected_path" | tr '.' '_')

  # Create the new session on demand.
  if ! tmux has-session -t="$session_name" 2> /dev/null; then
      tmux new-session -ds "$session_name" -c "$selected_path"
      echo "tmux new-session -ds $session_name-c $selected_path" >> ~/tmux-sessioniser.log
  fi

  # Switch to the new session.
  tmux switch-client -t "$session_name"

  # Delete current session if it was not created with a project.
  num_pattern='^[0-9]+$'
  if ! [[ $cur_session_name =~ $num_pattern ]] ; then
    tmux kill-window
    echo "tmux kill-window"  >> ~/tmux-sessioniser.log
  else
    tmux kill-session -t "$cur_session_name"
    echo "tmux kill-session -t $cur_session_name" >> ~/tmux-sessioniser.log
  fi
elif [[ $1 == "session" ]] ; then
  # Get the path.
  selected_session=$(\
    bash -c "tmux list-session \
            | awk -F ':' '{print \$1}' \
            | fzf --no-height --tac"
  )
  # When fzf is interrupted by ctrl+c, it returns an empty string.
  if [[ -z $selected_session ]]; then
    exit 0
  fi
  selected_session="$root_dir/$selected_session"
  tmux switch -t "$selected_session"
fi
