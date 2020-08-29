# PATH

# Editor
export EDITOR='vim'

# Aliases
alias ls='ls --color=auto'

# pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Run WSL GUI apps on Windows
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
