# =============================================================================
#                               Local Configs
# =============================================================================
[[ -f "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"

# =============================================================================
#                                   Shell
# =============================================================================
# tab-complete hidden items
_comp_options+=(globdots)

# =============================================================================
#                                App settings
# =============================================================================
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source "$HOME/.config/fzf/completion.zsh"
source "$HOME/.config/fzf/key-bindings.zsh"

# =============================================================================
#                                  Aliases
# =============================================================================
alias vim="nvim"
command -v exa >/dev/null 2>&1 || alias ls="exa"

# =============================================================================
#                                 Functions
# =============================================================================
function ef() { fzf | xargs -o vim }
function opf() { fzf | xargs -o open > /dev/null 2>&1 }

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
