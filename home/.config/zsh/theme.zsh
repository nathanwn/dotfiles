# Add some colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Available:
# - bsol
# - papercolor-light
# export GLOBAL_THEME="papercolor-light"
export GLOBAL_THEME="base16-solarized-dark"

if [ -n "$TMUX" ] && [ -x "$(command -v tmux)" ] ; then
  if [[ $GLOBAL_THEME == base16-* ]]; then
    tmux source-file "$HOME/.local/share/base16/tinted-tmux/colors/${GLOBAL_THEME}.conf"
  else
    tmux source-file "${HOME}/.config/tmux/themes/${GLOBAL_THEME}.tmux"
  fi
fi

if [ -x "$(command -v vivid)" ]; then
  if vivid themes | grep -q "${GLOBAL_THEME}"; then
    LS_COLORS="$(vivid generate "${GLOBAL_THEME}")"
  fi
fi

export LS_COLORS
