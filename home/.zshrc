function source_if_exists () {
  FILE=$1 && test -e $FILE && source $FILE
}

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/opt:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
source_if_exists "$HOME/.config/zsh/local.zsh"

# -----------------------------------------------------------------------------
#                                  Theming
# -----------------------------------------------------------------------------
# Available:
# DEFAULT_THEME="papercolor-light"
# DEFAULT_THEME="solarized-dark"
# DEFAULT_THEME="nvim-light"

# DEFAULT_DARK_THEME="tokyonight-storm"
# DEFAULT_LIGHT_THEME="nvim-light"

DEFAULT_DARK_THEME="catppuccin-frappe"
DEFAULT_LIGHT_THEME="catppuccin-latte"

function reload_theme() {
  if (($# > 0)); then
    GLOBAL_THEME="$1"
  else
    GLOBAL_THEME="$(cat $GLOBAL_THEME_FILE)"
  fi
  export GLOBAL_THEME
  if [ -n "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
    source_if_exists "$HOME/.config/zsh/themes/${GLOBAL_THEME}.zsh"
    tmux source-file "$HOME/.config/tmux/themes/${GLOBAL_THEME}.tmux"
    tmux source-file "$HOME/.config/tmux/themes/base-theme.tmux"
  fi

  # vivid
  if [ -x "$(command -v vivid)" ]; then
    if vivid themes | grep -q "${GLOBAL_THEME}"; then
      LS_COLORS="$(vivid generate "${GLOBAL_THEME}")"
    fi
  fi
  export LS_COLORS

  # fzf
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=bg:$TMUX_BG,fg:$TMUX_FG,hl:$TMUX_ACCENT,bg+:$TMUX_BAR_BG,fg+:$TMUX_FG,hl+:$TMUX_ACCENT,info:$TMUX_ACCENT,prompt:$TMUX_ACCENT,pointer:$TMUX_ACCENT,marker:$TMUX_ACCENT,spinner:$TMUX_ACCENT,header:$TMUX_ACCENT"
}

# Add some colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"

export GLOBAL_THEME_FILE="$HOME/.local/share/zsh/local_theme.txt"
if [ ! -f "$GLOBAL_THEME_FILE" ]; then
  mkdir -p "$HOME/.local/share/zsh"
  touch "$GLOBAL_THEME_FILE"
fi
PREV_GLOBAL_THEME="$(cat "$GLOBAL_THEME_FILE")"

if [[ $(uname) == "Darwin" ]]; then
  if defaults read -g AppleInterfaceStyle 2> /dev/null | grep -q "Dark" ; then
    GLOBAL_THEME="$DEFAULT_DARK_THEME"
  else
    GLOBAL_THEME="$DEFAULT_LIGHT_THEME"
  fi
else
  GLOBAL_THEME="$DEFAULT_DARK_THEME"
fi

if [[ "$PREV_GLOBAL_THEME" != "$GLOBAL_THEME" ]]; then
  tmux list-panes -a -F "#{pane_id}" | xargs -I PANE tmux send-keys -t PANE "reload_theme $GLOBAL_THEME" Enter
fi

echo "$GLOBAL_THEME" > "$GLOBAL_THEME_FILE"
export GLOBAL_THEME
reload_theme

# -----------------------------------------------------------------------------
#                              Shell settings
# -----------------------------------------------------------------------------
# tab-complete hidden items
_comp_options+=(globdots)
# editor
if [ -x "$(command -v nvim)" ]; then
  alias vim=nvim
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# -----------------------------------------------------------------------------
#                                App settings
# -----------------------------------------------------------------------------
# fzf
source_if_exists "$HOME/.config/fzf/completion.zsh"
source_if_exists "$HOME/.config/fzf/key-bindings.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh
if [ -z "$ZSH_SET" ]; then
  export ZSH_PLUGINS_DIR="/usr/share"
  export ZSH_USER_PLUGINS_DIR="$HOME/.local/share/zsh"

  zsh_syntax_highlighting="zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  if [ -f "$ZSH_PLUGINS_DIR/$zsh_syntax_highlighting" ]; then
    source "$ZSH_PLUGINS_DIR/$zsh_syntax_highlighting"
  elif [ -f "$ZSH_USER_PLUGINS_DIR/$zsh_syntax_highlighting" ]; then
    source "$ZSH_USER_PLUGINS_DIR/$zsh_syntax_highlighting"
  fi

  zsh_autosuggestions="$ZSH_USER_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  zsh_autosuggestions="zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  if [ -f "$ZSH_PLUGINS_DIR/$zsh_autosuggestions" ]; then
    source "$ZSH_PLUGINS_DIR/$zsh_autosuggestions"
  elif [ -f "$ZSH_USER_PLUGINS_DIR/$zsh_autosuggestions" ]; then
    source "$ZSH_USER_PLUGINS_DIR/$zsh_autosuggestions"
  fi

  if [ -d "$ZSH_USER_PLUGINS_DIR/zsh-completions/src" ]; then
    fpath=("$ZSH_USER_PLUGINS_DIR/zsh-completions/src" $fpath)
  fi
  bindkey '^Y' autosuggest-accept
  export ZSH_SET=1
fi

HISTFILE=~/.local/share/zsh/.history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/default.toml"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/large_repo.toml"
if [[ "$SHELL" = *zsh ]]; then
  # Starship: https://github.com/starship/starship
  if [ -x "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
  else
    precmd() { print "" }
    export PS1="%{%F{blue}%}%3~"$'\n'"> %{%f%}% "
  fi
fi

# Keep scrollback buffer when typing clear
alias clear="clear -x"
# Enable vi-mode
bindkey -v

[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
[ -x "$(command -v fdfind)" ] && alias fd="fdfind"

function gpath() {
  if [ -x "$(command -v xclip)" ] && cat /proc/version | grep -q "WSL" ; then
    wslpath -w "$PWD" | xclip -selection clipboard
  else
    pwd | xclip -selection clipboard
  fi
}

alias git-zip='git archive --format zip -o "$(basename $PWD).zip" HEAD'
alias du-list='du -sh * | sort -rh'

if [[ $(uname) == "Darwin" ]]; then
  source "$HOME/.config/zsh/darwin.zsh"
elif [[ "$(cat /proc/sys/kernel/osrelease)" == *"WSL2" ]]; then
  source "$HOME/.config/zsh/wsl2.zsh"
fi

function enable_sdkman() {
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

function enable_nvm() {
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# Go
export PATH="$PATH:/usr/local/go/bin"

# Android
export ANDROID_HOME="$HOME/sdk"
if [[ $(uname) == "Darwin" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
else
  export ANDROID_HOME="$HOME/.local/share/android/sdk"
fi
