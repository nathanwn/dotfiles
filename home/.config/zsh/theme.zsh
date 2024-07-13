# Available:
# - bsol
# - papercolor-light
export GLOBAL_THEME="papercolor-light"

if [ -n "$TMUX" ] && [ -x "$(command -v tmux)" ] ; then
  tmux source-file "${HOME}/.config/tmux/themes/${GLOBAL_THEME}.tmux"
fi

if [ -x "$(command -v vivid)" ]; then
  if vivid themes | grep -q "${GLOBAL_THEME}"; then
    LS_COLORS="$(vivid generate "${GLOBAL_THEME}")"
  fi
fi

# export LS_COLORS
