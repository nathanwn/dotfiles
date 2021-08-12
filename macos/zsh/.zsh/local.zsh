# =============================================================================
#                                    PATH
# =============================================================================

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# scripts
export PATH="$HOME/.scripts:$PATH"
# neovim
export PATH="$HOME/bin/nvim-osx64/bin:$PATH"
# vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# latex
export PATH="$PATH:/Library/TeX/texbin"
# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"
# qt
export PATH="$HOME/apps/Qt/5.12.6/clang_64/bin:$PATH"
export PATH="/usr/local/Cellar/gcc/10.2.0/bin:$PATH"
# flutter
export PATH="$HOME/development/flutter/bin:$PATH"
# chromedriver
export PATH="$HOME/development/chromedriver:$PATH"
# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# LLVM stuff
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

export LC_ALL=en_US.UTF-8

# =============================================================================
#                                  ALIASES
# =============================================================================
alias javacli="/usr/libexec/java_home"
alias gpath="pwd|pbcopy"
alias term="open -a Terminal \"`pwd`\""
alias java_versions="/usr/libexec/java_home -V"
