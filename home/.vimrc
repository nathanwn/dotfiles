if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-tmux-navigator'
  " Plug 'NLKNguyen/papercolor-theme'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
call plug#end()
" Filetype
syntax on
filetype plugin indent on
" Line number
set nu rnu
" Indentation
set autoindent     " indents like the previous line
"set smartindent   " add one level of indentation in some cases
set tabstop=4      " hard tab stop
set shiftwidth=4   " when indenting with '>', add 4 spaces
set softtabstop=4  " soft tab stop
set expandtab      " on pressing tab, insert 4 spaces
" Cursor
set guicursor=     " block cursor for all modes
" Split right and below
set splitbelow
set splitright
" Accessing system clipboard
set clipboard=unnamed,unnamedplus
" Undo files
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" Error bells
set noerrorbells
" Scrolling
set scrolloff=8
" Highlight search
set nohlsearch
" Statusline
set laststatus=2
set statusline=%f        " File path
set statusline+=\ %m     " Modified flag [+]
set statusline+=\ %r     " Read-only flag
set statusline+=%=       " Right align the following items
set statusline+=\ %l,%c  " Line and column number

" Indent
vnoremap < <gv
vnoremap > >gv

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-w>\ :TmuxNavigatePrevious<cr>
