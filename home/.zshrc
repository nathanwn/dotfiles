function source_if_exists () {
  FILE=$1 && test -e $FILE && source $FILE
}

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/opt:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
source_if_exists "$HOME/.config/zsh/local.zsh"
source_if_exists "$HOME/.config/zsh/proxy.zsh"
source_if_exists "$HOME/.config/zsh/theme.zsh"
source_if_exists "$HOME/.config/zsh/ansible.zsh"

# -----------------------------------------------------------------------------
#                              Shell settings
# -----------------------------------------------------------------------------
# tab-complete hidden items
_comp_options+=(globdots)
# editor
if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# -----------------------------------------------------------------------------
#                                App settings
# -----------------------------------------------------------------------------
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source_if_exists "$HOME/.config/fzf/completion.zsh"
source_if_exists "$HOME/.config/fzf/key-bindings.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh
export ZSH_PLUGINS_DIR="$HOME/.local/share/zsh"
source_if_exists "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -d "$ZSH_PLUGINS_DIR/zsh-completions/src" ]; then
  fpath=("$ZSH_PLUGINS_DIR/zsh-completions/src" $fpath)
fi
bindkey '^Y' autosuggest-accept

if [[ "$SHELL" = *zsh ]]; then
  # Starship: https://github.com/starship/starship
  if [ -x "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
  fi
fi

# Keep scrollback buffer when typing clear
alias clear="clear -x"
alias ls="ls --color=auto"
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
[ -x "$(command -v xclip)" ] && alias gpath="pwd | xclip -sel clip"

# vi-mode
bindkey -v

if [[ $(uname) == "Darwin" ]]; then
  source "$HOME/.config/zsh/darwin.zsh"
fi
