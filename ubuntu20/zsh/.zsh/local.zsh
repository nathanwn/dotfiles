# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
export PATH="$HOME/.local/bin:$PATH"

# Shell programs
# exa
export PATH="$HOME/bin/exa/exa-linux-x86_64-v0.10.0/bin:$PATH"

# Languages & Tools
# c++
export PATH="$HOME/bin/ccls/Release:$PATH"
# dart
export PATH="/usr/lib/dart/bin:$PATH"
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# pascal
export PATH="$HOME/bin/fpc-3.2.0/bin:$PATH"
# rust
FILE="$HOME/.cargo/env" && test -f $FILE && source $FILE
# tex
export PATH="$HOME/bin/texlab/target/release:$PATH"

# infer
export PATH="$HOME/bin/infer/infer-linux64-v1.1.0/bin:$PATH"

# Applications
# spotifyd
export PATH="$HOME/bin/spotifyd/target/release:$PATH"
# qpdf
export PATH="$HOME/bin/qpdf/qpdf/build:$PATH"

alias gpath="pwd | xclip -selection clipboard"
