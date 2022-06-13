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
source_if_exists "$HOME/.cargo/env"

# nix
source_if_exists "$HOME/.nix-profile/etc/profile.d/nix.sh"
source_if_exists "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:$NIX_PATH}


# Applications
# mcfly
source_if_exists "$HOME/.config/zsh/mcfly.zsh"
# neovim
export PATH="$HOME/bin/nvim/bin:$PATH"

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
