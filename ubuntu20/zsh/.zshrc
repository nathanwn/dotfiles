# =============================================================================
#                                   Shell
# =============================================================================
# tab-complete hidden items
_comp_options+=(globdots)

# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
# local
export PATH="$HOME/.local/bin:$PATH"
# exa
export PATH="$HOME/bin/exa/exa-linux-x86_64-v0.10.0/bin:$PATH"
# dart
export PATH="/usr/lib/dart/bin:$PATH"
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# pascal
export PATH="$HOME/bin/fpc-3.2.0/bin:$PATH"

# EDITOR
export EDITOR=nvim

# =============================================================================
#                                App settings
# =============================================================================
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

# =============================================================================
#                                  Aliases
# =============================================================================
alias vim="nvim"
alias open="xdg-open"
alias ls="exa"

# =============================================================================
#                                 Functions
# =============================================================================
function ef() { fzf | xargs -o vim }
function opf() { fzf | xargs -o xdg-open > /dev/null 2>&1 }

# =============================================================================
#                                Key-bindings
# =============================================================================
# vi-mode
bindkey -v

# =============================================================================
#                                   Theme
# =============================================================================
# Starship: https://github.com/starship/starship
eval "$(starship init zsh)"

# =============================================================================
#                               Auto-generated
# =============================================================================
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# conda
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
