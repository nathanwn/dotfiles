# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
export PATH="$HOME/.local/bin:$PATH"

# scripts
export PATH="$HOME/bin/scripts:$PATH"

# Languages & Tools
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# node
export PATH="$HOME/.local/share/node-global-env/node_modules/.bin:$PATH"
# rust
FILE="$HOME/.cargo/env" && test -f $FILE && source $FILE
# Applications
# spotifyd
# export PATH="$HOME/bin/spotifyd/target/release:$PATH"
# qpdf
# export PATH="$HOME/bin/qpdf/qpdf/build:$PATH"

alias gpath="pwd | xclip -selection clipboard"

function zath() { nohup zathura $1 > /dev/null & disown & }
function imgview() { nohup sxiv $1 > /dev/null & disown & }

# -----------------------------------------------------------------------------
#                               Key bindings
# -----------------------------------------------------------------------------
# tldr
bindkey -s "^T" "tldrf^[^M"

# -----------------------------------------------------------------------------
#                               Auto-generated
# -----------------------------------------------------------------------------
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
