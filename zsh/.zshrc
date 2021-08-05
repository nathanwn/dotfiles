# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
FILE="$HOME/.zsh/local.zsh" && test -f $FILE && source $FILE

# -----------------------------------------------------------------------------
#                                   Shell
# -----------------------------------------------------------------------------
# tab-complete hidden items
_comp_options+=(globdots)

# -----------------------------------------------------------------------------
#                                   Editor
# -----------------------------------------------------------------------------
if [ -x "nvim" ] ; then
   export EDITOR=nvim
else
   export EDITOR=vim
fi

# -----------------------------------------------------------------------------
#                                App settings
# -----------------------------------------------------------------------------
# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# -----------------------------------------------------------------------------
#                                  Aliases
# -----------------------------------------------------------------------------
[ -x "$(command -v nvim)" ] && alias vim="nvim";
[ -x "$(command -v exa)"  ] && alias ls="exa";

# -----------------------------------------------------------------------------
#                                Key-bindings
# -----------------------------------------------------------------------------
# vi-mode
bindkey -v
# fzf
FILE="$HOME/.config/fzf/completion.zsh"   && test -f $FILE && source $FILE
FILE="$HOME/.config/fzf/key-bindings.zsh" && test -f $FILE && source $FILE

# -----------------------------------------------------------------------------
#                                   Theme
# -----------------------------------------------------------------------------
# Starship: https://github.com/starship/starship
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"

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
