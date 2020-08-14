# =============================================================================
# AUTHOR: Minh Nhat Nguyen
# VERSION: 27-02-2020
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# ~/.bash_prompt: executed by bash(1) for login shells. (not really needed tbh)
# =============================================================================


# -----------------------------------------------------------------------------
# HISTORY
# -----------------------------------------------------------------------------
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# history length
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# -----------------------------------------------------------------------------
# PROMPT
# -----------------------------------------------------------------------------
# color reference: https://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html

# git
prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  git rev-parse --is-inside-work-tree &>/dev/null || return;

  # Check for what branch we’re on.
  # Get the short symbolic ref. If HEAD isn’t a symbolic ref, get a
  # tracking remote branch or tag. Otherwise, get the
  # short SHA for the latest commit, or give up.
  branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git describe --all --exact-match HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

  # Early exit for Chromium & Blink repo, as the dirty check takes too long.
  # Thanks, @paulirish!
  # https://github.com/paulirish/dotfiles/blob/dd33151f/.bash_prompt#L110-L123
  repoUrl="$(git config --get remote.origin.url)";
  if grep -q 'chromium/src.git' <<< "${repoUrl}"; then
    s+='*';
  else
    # Check for uncommitted changes in the index.
    if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
    fi;
    # Check for unstaged changes.
    if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
    fi;
    # Check for untracked files.
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
    fi;
    # Check for stashed files.
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
    fi;
  fi;

  [ -n "${s}" ] && s=" [${s}]";

  echo -e "${1}${branchName}${2}${s}";
}

# colors
reset="\033[00m";
red="\033[01;31m";
yellow="\033[01;32m";
orange="\033[01;33m";
blue="\033[01;34m";
purple="\033[01;35m";
green="\033[01;36m";

PS1="\\n";
PS1+="\[${yellow}\]";
PS1+="\u@\h";
PS1+="\[\033[00m\] ";
PS1+="\[${blue}\]";
PS1+="\w";
PS1+="\[\033[00m\] ";
PS1+="\$(prompt_git \"\[${purple}\] on \[${green}\]\" \"\[${red}\]\")"; # Git repository details
PS1+="\\n";
PS1+="\[${orange}\]";
PS1+="-> ";
PS1+="\[${reset}\]";
export PS1;

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  #alias grep='grep --color=auto'
  #alias fgrep='fgrep --color=auto'
  #alias egrep='egrep --color=auto'
fi

# -----------------------------------------------------------------------------
# THEME
# -----------------------------------------------------------------------------
# Base16 Shell Color Theme
# BASE16_SHELL="$HOME/.config/base16-shell/"
#     [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#     eval "$("$BASE16_SHELL/profile_helper.sh")"


#
function geany () {
    nohup geany "$@" > /dev/null 2>&1 & disown
}

export JAVA_HOME="/usr/lib/jvm/jdk-13.0.2/bin/"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nhat/.sdkman"
[[ -s "/home/nhat/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nhat/.sdkman/bin/sdkman-init.sh"


