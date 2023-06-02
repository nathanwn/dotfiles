# export PATH="$HOME/bin/graalvm-ce-java17-22.3.0/bin:$PATH"

# Available:
# - bsol
# - papercolor-light
export GLOBAL_THEME="papercolor-light"

if [ -n "$TMUX" ] && [ -x "$(command -v tmux)" ] ; then
  tmux source-file "${HOME}/.config/tmux/themes/${GLOBAL_THEME}.tmux"
fi
[ -x "$(command -v vivid)" ] && export LS_COLORS="$(vivid generate "${GLOBAL_THEME}")"
