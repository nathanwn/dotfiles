function source_if_exists () {
  FILE=$1 && test -e $FILE && source $FILE
}

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/opt:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

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
export ZSH_PLUGINS_DIR="/usr/share"
export ZSH_USER_PLUGINS_DIR="$HOME/.local/share/zsh"

zsh_syntax_highlighting="zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$ZSH_PLUGINS_DIR/$zsh_syntax_highlighting" ]; then
  source "$ZSH_PLUGINS_DIR/$zsh_syntax_highlighting"
elif [ -f "$ZSH_USER_PLUGINS_DIR/$zsh_syntax_highlighting" ]; then
  source "$ZSH_USER_PLUGINS_DIR/$zsh_syntax_highlighting"
fi

zsh_autosuggestions="$ZSH_USER_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
zsh_autosuggestions="zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$ZSH_PLUGINS_DIR/$zsh_autosuggestions" ]; then
  source "$ZSH_PLUGINS_DIR/$zsh_autosuggestions"
elif [ -f "$ZSH_USER_PLUGINS_DIR/$zsh_autosuggestions" ]; then
  source "$ZSH_USER_PLUGINS_DIR/$zsh_autosuggestions"
fi

if [ -d "$ZSH_USER_PLUGINS_DIR/zsh-completions/src" ]; then
  fpath=("$ZSH_USER_PLUGINS_DIR/zsh-completions/src" $fpath)
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
# Enable vi-mode
bindkey -v

[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"

function gpath() {
  if [ -x "$(command -v xclip)" ] && cat /proc/version | grep -q "WSL" ; then
    wslpath -w "$PWD" | xclip -selection clipboard
  else
    pwd | xclip -selection clipboard
  fi
}

if [[ $(uname) == "Darwin" ]]; then
  source "$HOME/.config/zsh/darwin.zsh"
fi
