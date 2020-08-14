# PATH
export JAVA_HOME="/usr/lib/jvm/jdk-13.0.2/"
export PATH="$JAVA_HOME:$PATH"

# Editor
export EDITOR='vim'

# Aliases
alias ls='ls --color=auto'

# pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nhat/.sdkman"
[[ -s "/home/nhat/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nhat/.sdkman/bin/sdkman-init.sh"
