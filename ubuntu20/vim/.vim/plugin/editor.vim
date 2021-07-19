" = Filetype
filetype plugin indent on
" = Automatically source custom .vimrc
set exrc
" = Line number
set nu rnu
" = Indentation
set autoindent     " indents like the previous line
"set smartindent   " add one level of indentation in some cases
set tabstop=4      " hard tab stop
set shiftwidth=4   " when indenting with '>', add 4 spaces
set softtabstop=4  " soft tab stop
set expandtab      " on pressing tab, insert 4 spaces
" = Cursor
set guicursor=     " block cursor for all modes
" = Highlight search
" = Split right and below set splitbelow
set splitright
" = Accessing system clipboard
set clipboard=unnamed,unnamedplus
" = Undo files
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" Error bells
set noerrorbells
" Scrolling
set scrolloff=8
