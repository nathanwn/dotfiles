# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
export PATH="$HOME/.local/bin:$PATH"

# scripts
export PATH="$HOME/bin/scripts:$PATH"

# Languages & Tools
# c++
export PATH="$HOME/bin/ccls/Release:$PATH"
# dart
export PATH="/usr/lib/dart/bin:$PATH"
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# rust
FILE="$HOME/.cargo/env" && test -f $FILE && source $FILE

# Applications
# spotifyd
# export PATH="$HOME/bin/spotifyd/target/release:$PATH"
# qpdf
# export PATH="$HOME/bin/qpdf/qpdf/build:$PATH"

alias gpath="pwd | xclip -selection clipboard"

function run_and_disown() { nohup $1 $2 > /dev/null & disown & }
function zath() { run_and_disown zathura $1 }
function imgview() { nohup sxiv $1 > /dev/null & disown & }

# -----------------------------------------------------------------------------
#                               Key bindings
# -----------------------------------------------------------------------------
# tldr
bindkey -s "^T" "tldrf^[^M"
