# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline-multiline"

# completions can be found in ~/.oh-my-bash/completions/*
completions=(
  git
  composer
  ssh
)

# aliases can be found in ~/.oh-my-bash/aliases/*
aliases=(
  general
)

# plugins can be found in ~/.oh-my-bash/plugins/*
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# History
# no duplicate lines
HISTCONTROL=ignoreboth
# append, not overwrite
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Path
# export PATH="/data/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/data/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/data/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

