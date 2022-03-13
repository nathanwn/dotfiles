# =============================================================================
#                           Environment Variables
# =============================================================================
# PATH
export PATH="$HOME/.local/bin:$PATH"

# Shell programs
# exa
export PATH="$HOME/bin/exa/exa-linux-x86_64-v0.10.0/bin:$PATH"
# nvim
# export PATH="$HOME/bin/nvim-linux64/bin:$PATH"
export PATH="$HOME/bin/nvim/bin:$PATH"

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
# scala
export PATH="$HOME/bin/scala/scala-2.12.14/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
# tex
export PATH="$HOME/bin/texlab/target/release:$PATH"

# infer
export PATH="$HOME/bin/infer/infer-linux64-v1.1.0/bin:$PATH"
# hadolint
export PATH="$HOME/bin/hadolint:$PATH"

# Applications
# spotifyd
export PATH="$HOME/bin/spotifyd/target/release:$PATH"
# qpdf
export PATH="$HOME/bin/qpdf/qpdf/build:$PATH"

alias gpath="pwd | xclip -selection clipboard"

function zath() { nohup zathura $1 > /dev/null & disown & }
function imgview() { nohup sxiv $1 > /dev/null & disown & }

# -----------------------------------------------------------------------------
#                               Auto-generated
# -----------------------------------------------------------------------------
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
