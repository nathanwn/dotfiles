# Languages & Tools
# go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
# rust
FILE="$HOME/.cargo/env" && test -f $FILE && source $FILE
source_if_exists "$HOME/.cargo/env"

function zath() { nohup zathura $1 > /dev/null & disown & }
function imgview() { nohup sxiv $1 > /dev/null & disown & }

# -----------------------------------------------------------------------------
#                               Auto-generated
# -----------------------------------------------------------------------------
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
