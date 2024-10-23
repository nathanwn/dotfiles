set -g mode-style "fg=#2e2e2e,bg=#d8d8d8"
set -wg mode-style "fg=#2e2e2e,bg=#d8d8d8"

set -g message-style "fg=#2e2e2e,bg=#d8d8d8"
set -g message-command-style "fg=#2e2e2e,bg=#d8d8d8"

set -g pane-border-style "fg=#d8d8d8"
set -g pane-active-border-style "fg=#2e2e2e"

set -g status-style "fg=#2e2e2e,bg=#c9c9c9"
set -g status-left "#[fg=#eeeeee,bg=#005faf,bold] #S #[fg=#2e2e2e,bg=#c9c9c9,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#eeeeee,bg=#005faf,bold] #h "

setw -g window-status-activity-style "underscore,fg=#2e2e2e,bg=#c9c9c9"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#2e2e2e,bg=#c9c9c9"
setw -g window-status-format "#[fg=#c9c9c9,bg=#c9c9c9,nobold,nounderscore,noitalics]#[default] #I:#W#F #[fg=#c9c9c9,bg=#c9c9c9,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#c9c9c9,bg=#d9d9d9,nobold,nounderscore,noitalics]#[fg=#005faf,bg=#d9d9d9,bold] #I:#W#F #[fg=#d9d9d9,bg=#c9c9c9,nobold,nounderscore,noitalics]"
