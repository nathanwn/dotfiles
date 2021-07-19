" This file is pretty empty for now.
" All of the persistent settings are in the ~/.vim/plugin/ directory

" -----------------------------------------------------------------------------
"                            Plugin Installation
" -----------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " Git
  Plug 'tpope/vim-fugitive'
  " Tmux
  Plug 'christoomey/vim-tmux-navigator'
  " Themes
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  " TS, React
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  " Emmet
  Plug 'mattn/emmet-vim'
  " Neovim only
  if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release' }
    Plug 'fatih/vim-go'
  else
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}
    Plug 'fatih/vim-go',      {'on': []}
  endif
call plug#end()

" -----------------------------------------------------------------------------
"                                   Themes
" -----------------------------------------------------------------------------
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'

" -----------------------------------------------------------------------------
"                                Key bindings
" -----------------------------------------------------------------------------
" = Leader key
" By default it is the backslash key
let mapleader=" "

" = Keep selection when re-indenting
vnoremap < <gv
vnoremap > >gv

" = Enter Paste Mode
set pastetoggle=<F3>

" = Toggle Conceal
let s:conceal_on = 0
nmap \cc :call ToggleConceal()<CR>

" = Need this for `a` in normal-mode to work properly
nnoremap e he

" autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * call RemoveTrailingWhitespace()

" = Centering selected text
nmap \ac "xy:echo(AlignCenter(80))<CR>

" = Execute selected shell command
vnoremap \ex :w !bash<CR>

" = Copy path to clipboard
nmap \cp :let @+=expand("%:p")<CR>
