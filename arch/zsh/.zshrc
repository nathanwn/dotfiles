# PATH
# export JAVA_HOME="/opt/jdk-13.0.2/"
# export PATH="$PATH:$JAVA_HOME/bin"

# Editor
export EDITOR='vim'

# Aliases
alias ls='ls --color=auto'

# pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
