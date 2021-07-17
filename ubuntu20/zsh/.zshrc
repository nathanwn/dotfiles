# =============================================================================
#                                   Shell
# =============================================================================
# tab-complete hidden items
_comp_options+=(globdots)

# =============================================================================
#                           Environment Variables
# =============================================================================
# local
export PATH="$HOME/.local/bin:$PATH"
# dart
export PATH="/usr/lib/dart/bin:$PATH"
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# conda
export PATH="$HOME/miniconda3/bin:$PATH"

export EDITOR=nvim

# =============================================================================
#                                App settings
# =============================================================================
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# =============================================================================
#                           Aliases & Key-bindings
# =============================================================================
alias e="nvim"
alias vim="nvim"
alias open="xdg-open"
function ef() { fzf | xargs -o vim }
function opf() { fzf | xargs -o xdg-open > /dev/null 2>&1 }
# bindkey -s "^i" "ef\n"
# bindkey -s "^o" "opf\n"

# =============================================================================
#                                   Theme
# =============================================================================
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
