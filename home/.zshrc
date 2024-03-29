# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
source_if_exists "$HOME/.config/zsh/private.zsh"
source_if_exists "$HOME/.config/zsh/theme.zsh"
source_if_exists "$HOME/.config/zsh/env.zsh"

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

# vivid
# [ -x "$(command -v vivid)" ] && export LS_COLORS="$(vivid generate one-light)"
# [ -x "$(command -v vivid)" ] && export LS_COLORS="$(vivid generate one-dark)"
# [ -x "$(command -v vivid)" ] && export LS_COLORS="$(vivid generate bsol)"

# zsh
export ZSH_PLUGINS_DIR="$HOME/.local/share/zsh"
source_if_exists "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -d "$ZSH_PLUGINS_DIR/zsh-completions/src" ]; then
  fpath=("$ZSH_PLUGINS_DIR/zsh-completions/src" $fpath)
fi
bindkey '^Y' autosuggest-accept

if [[ "$SHELL" = *zsh ]]; then
  # https://github.com/romkatv/powerlevel10k
  if [ -d "$ZSH_PLUGINS_DIR/powerlevel10k" ]; then
    source "$ZSH_PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme"
  # Starship: https://github.com/starship/starship
  elif [ -x "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
  fi
fi

alias ls="ls --color=auto"

# Keep scrollback buffer when typing clear
alias clear="clear -x"
# [ -x "$(command -v nvim)" ] && alias vim="nvim"
# [ -x "$(command -v bat)" ] && alias cat="bat"
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
[ -x "$(command -v xclip)" ] && alias gpath="pwd | xclip -sel clip"

# vi-mode (disable in nvim terminal)
bindkey -v
# env | grep -q "NVIM_LISTEN_ADDRESS" || bindkey -v  # (disable in nvim terminal)

# Alacritty issue in VirtualBox
# See: https://github.com/archlinux/archinstall/issues/1104#issuecomment-1370096003
# export  LIBGL_ALWAYS_SOFTWARE=true

if [[ $(uname) == "Darwin" ]]; then
  source "$HOME/.config/zsh/darwin.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
