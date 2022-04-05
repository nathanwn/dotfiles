function source_if_exists () {
  FILE=$1 && test -f $FILE && source $FILE
}

# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
# FILE="$HOME/.zsh/local.zsh" && test -f $FILE && source $FILE
source_if_exists "$HOME/.zsh/local.zsh"

# -----------------------------------------------------------------------------
#                              Shell settings
# -----------------------------------------------------------------------------
# tab-complete hidden items
_comp_options+=(globdots)
# editor
if [ -x "nvim" ] ; then
   export EDITOR=nvim
else
   export EDITOR=vim
fi

# -----------------------------------------------------------------------------
#                                App settings
# -----------------------------------------------------------------------------
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# vi-mode (disable in nvim terminal)
env | grep -q "NVIM_LISTEN_ADDRESS" || bindkey -v
# fzf
source_if_exists "$HOME/.config/fzf/completion.zsh"
source_if_exists "$HOME/.config/fzf/key-bindings.zsh"
# mcfly
FILE="$HOME/.config/zsh/mcfly.zsh" && test -f $FILE && source $FILE


# -----------------------------------------------------------------------------
#                                  Aliases
# -----------------------------------------------------------------------------
# [ -x "$(command -v nvim)" ] && alias vim="nvim"
[ -x "$(command -v exa)"  ] && alias ls="exa"
[ -x "$(command -v bat)"  ] && alias cat="bat"

# -----------------------------------------------------------------------------
#                                   Theme
# -----------------------------------------------------------------------------
if [ -x "$(command -v starship)" ] ; then
  # Starship: https://github.com/starship/starship
  eval "$(starship init zsh)"
elif [ -d "$HOME/.oh-my-zsh" ] ; then
  # oh-my-zsh
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="kphoen"
  plugins=(git)
  source $ZSH/oh-my-zsh.sh
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nhat/google-cloud-sdk/path.zsh.inc' ]; then . '/home/nhat/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/nhat/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/nhat/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
