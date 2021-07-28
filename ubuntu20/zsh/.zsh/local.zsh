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
# spotifyd
export PATH="$HOME/bin/spotifyd/target/release:$PATH"

alias gpath="pwd | xclip -selection clipboard"