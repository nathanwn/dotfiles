function source_if_exists () {
  FILE=$1 && test -e $FILE && source $FILE
}

# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
source_if_exists "$HOME/.config/zsh/local.zsh"
source_if_exists "$HOME/.config/zsh/proxy.zsh"
source_if_exists "$HOME/.config/zsh/private.zsh"

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
# vi-mode (disable in nvim terminal)
# env | grep -q "NVIM_LISTEN_ADDRESS" || bindkey -v

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# source_if_exists "$HOME/.config/fzf/completion.zsh"
# source_if_exists "$HOME/.config/fzf/key-bindings.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vivid
[ -x "$(command -v vivid)" ] && export LS_COLORS="$(vivid generate one-light)"

# zsh
source_if_exists "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -d "$HOME/.zsh/zsh-completions/src" ]; then
  fpath=("$HOME/.zsh/zsh-completions/src" $fpath)
fi
bindkey '^Y' autosuggest-accept
bindkey -v

# -----------------------------------------------------------------------------
#                                  Aliases
# -----------------------------------------------------------------------------
# [ -x "$(command -v nvim)" ] && alias vim="nvim"
[ -x "$(command -v exa)" ] && alias ls="exa"
# [ -x "$(command -v bat)" ] && alias cat="bat"
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
[ -x "$(command -v xclip)" ] && alias gpath="pwd | xclip -sel clip"

# -----------------------------------------------------------------------------
#                                   Theme
# -----------------------------------------------------------------------------
# Starship: https://github.com/starship/starship
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
