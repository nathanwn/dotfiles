# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
export PATH="$HOME/.local/bin:$PATH"

# scripts
export PATH="$HOME/bin/scripts:$PATH"

# Shell programs
# exa
export PATH="$HOME/bin/exa/exa-linux-x86_64-v0.10.0/bin:$PATH"
# nvim
# export PATH="$HOME/bin/nvim-linux64/bin:$PATH"
export PATH="$HOME/bin/nvim/bin:$PATH"

# Languages & Tools
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# rust
FILE="$HOME/.cargo/env" && test -f $FILE && source $FILE
# Applications
# spotifyd
export PATH="$HOME/bin/spotifyd/target/release:$PATH"
# qpdf
export PATH="$HOME/bin/qpdf/qpdf/build:$PATH"

alias gpath="pwd | xclip -selection clipboard"

function zath() { nohup zathura $1 > /dev/null & disown & }
function imgview() { nohup sxiv $1 > /dev/null & disown & }
