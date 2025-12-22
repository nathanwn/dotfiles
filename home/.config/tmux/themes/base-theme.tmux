# General
set -g mode-style "fg=#{@theme_fg},bg=#{@theme_bar_bg}"
set -g message-style "fg=#{@theme_fg},bg=#{@theme_bg}"

set -g pane-border-style "fg=#{@theme_border_soft}"
set -g pane-active-border-style "fg=#{@theme_accent}"

# Status Bar
set -g status-style "fg=#{@theme_fg},bg=#{@theme_bar_bg}"
set -g status-left-length "100"
set -g status-right-length "100"

# Status Left & Right
# Added a trailing space at the end of status-left to prevent text jumping
set -g status-left "#[fg=#{@theme_accent_fg},bg=#{@theme_accent},bold] #S #[fg=#{@theme_fg},bg=#{@theme_bar_bg},nobold] "
set -g status-right "#[fg=#{@theme_accent_fg},bg=#{@theme_accent},bold] #h "

# Window Tabs
setw -g window-status-separator ""

# Inactive Window: Added consistent padding
setw -g window-status-style "fg=#{@theme_fg},bg=#{@theme_bar_bg}"
setw -g window-status-format " #I:#W#F "

# Active Window: Uses the background color change but maintains the same text padding
setw -g window-status-current-format "#[fg=#{@theme_accent},bg=#{@theme_bg},bold] #I:#W#F "
