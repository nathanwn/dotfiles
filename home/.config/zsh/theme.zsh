# Available:
# DEFAULT_THEME="papercolor-light"
# DEFAULT_THEME="solarized-dark"
# DEFAULT_THEME="nvim-light"
DEFAULT_DARK_THEME="tokyonight-storm"
DEFAULT_LIGHT_THEME="nvim-light"

function reload_theme() {
  if [ -n "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
    if [[ $GLOBAL_THEME == base16-* ]]; then
      tmux source-file "$HOME/.local/share/base16/tinted-tmux/colors/${GLOBAL_THEME}.conf"
    else
      source_if_exists "$HOME/.config/zsh/themes/${GLOBAL_THEME}.zsh"
      tmux source-file "$HOME/.config/tmux/themes/${GLOBAL_THEME}.tmux"
      tmux source-file "$HOME/.config/tmux/themes/base-theme.tmux"
    fi
  fi

  # vivid
  if [ -x "$(command -v vivid)" ]; then
    if vivid themes | grep -q "${GLOBAL_THEME}"; then
      LS_COLORS="$(vivid generate "${GLOBAL_THEME}")"
    fi
  fi
  export LS_COLORS

  # fzf
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=bg:$TMUX_BG,fg:$TMUX_FG,hl:$TMUX_ACCENT,bg+:$TMUX_BAR_BG,fg+:$TMUX_FG,hl+:$TMUX_ACCENT,info:$TMUX_ACCENT,prompt:$TMUX_ACCENT,pointer:$TMUX_ACCENT,marker:$TMUX_ACCENT,spinner:$TMUX_ACCENT,header:$TMUX_ACCENT"
}

# Add some colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"

PREV_GLOBAL_THEME="$GLOBAL_THEME"

if defaults read -g AppleInterfaceStyle | grep -q "Dark"; then
  GLOBAL_THEME="$DEFAULT_DARK_THEME"
else
  GLOBAL_THEME="$DEFAULT_LIGHT_THEME"
fi

if [[ "$PREV_GLOBAL_THEME" != "$GLOBAL_THEME" ]]; then
  tmux list-panes -a -F "#{pane_id}" | xargs -I PANE tmux send-keys -t PANE "reload_theme" Enter
fi

export GLOBAL_THEME
