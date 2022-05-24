# history
export HISTFILE="$HOME/.local/share/zsh/history"
export HISTSIZE=1000
export SAVEHIST=1000
setopt SHARE_HISTORY

if [[ -x "$(command -v mcfly)" ]]
then
  eval "$(mcfly init zsh)"
  # light theme
  # export MCFLY_LIGHT=TRUE
  export MCFLY_KEY_SCHEME=vim
  # export MCFLY_INTERFACE_VIEW=BOTTOM
  # export MCFLY_DISABLE_MENU=TRUE
fi
