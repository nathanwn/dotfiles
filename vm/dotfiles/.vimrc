" =============================================================================
" AUTHOR: Minh Nhat Nguyen
" VERSION: 27-02-2020
" =============================================================================

" -----------------------------------------------------------------------------
"                                   PLUGINS
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

  " = Theme
  Plug 'chriskempson/base16-vim'
  Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
  Plug 'vim-scripts/EditPlus'
  " Plug 'ocykat/muse.vim'

  " = Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()

" plasticboy/vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1


" -----------------------------------------------------------------------------
"                                     EDITOR
" -----------------------------------------------------------------------------
" = Filetype
"
filetype on
filetype plugin on
filetype indent on

" = Terminal Color
syntax enable
set t_Co=256
if !has('nvim')
  set term=screen-256color
endif

" = Line number with relative line number on
set nu
set rnu

" = Indentation
" .Global
set autoindent     " indents like the previous line
"set smartindent   " add one level of indentation in some cases
set tabstop=4      " hard tab stop
set shiftwidth=4   " when indenting with '>', add 4 spaces
set softtabstop=4  " soft tab stop
set expandtab      " on pressing tab, insert 4 spaces

" = Word wrapping
set wrap
set linebreak

" = Backspace issue
set backspace=indent,eol,start

" = Backup files: off
set nobackup
set nowritebackup
no backup files
set noswapfile
set noundofile

" = Window splitting
set splitright  "split to right for vsplit
set splitbelow  "split below for split

" = Ruler
"set colorcolumn=80

" = Remove trailing whitespaces automatically
autocmd BufWritePre * %s/\s\+$//e

" = Clipboard setting for copy & paste
" Make vim use the system clipboard
set clipboard=unnamed,unnamedplus

" = Error bells: off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" -----------------------------------------------------------------------------
"                                  THEME
" -----------------------------------------------------------------------------
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

colorscheme muse



" -----------------------------------------------------------------------------
"                                KEY BINDINGS
" -----------------------------------------------------------------------------
" = Leader key
let mapleader=","

" = Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap \oc :e ~/.vim/colors/muse.vim<CR>

" = vimrc
nmap \ev :e ~/.vimrc<CR>
nmap \vv :vsplit ~/.vimrc<CR>
nmap \sv :source $MYVIMRC<CR>

" = Enter Paste Mode
set pastetoggle=<F3>

" = Toggle Conceal
let s:conceal_on = 0
function! ToggleConceal()
	if s:conceal_on
		set conceallevel=2
		let s:conceal_on = 0
	else
		set conceallevel=0
		let s:conceal_on = 1
	endif
endfunction
nmap \cc :call ToggleConceal()<CR>


" = Indent keeping selection
vmap < <gv
vmap > >gv

" = Execute Shell command under selection
vnoremap \ex :w !bash<CR>

" = Copy path to clipboard
nmap \cp :let @+=expand("%:p")<CR>


" -----------------------------------------------------------------------------
"                               LANGUAGE-SPECIFIC
" -----------------------------------------------------------------------------
function! SetIndentSize(indentsize)
  let &l:tabstop     = a:indentsize
  let &l:shiftwidth  = a:indentsize
  let &l:softtabstop = a:indentsize
endfunction

function LangC()
  setlocal colorcolumn=80
endfunction

function LangMarkdown()
  call SetIndentSize(2)
endfunction

function LangSh()
  call SetIndentSize(2)
endfunction

function LangVim()
  call SetIndentSize(2)
endfunction

autocmd filetype c        call LangC()
autocmd filetype markdown call LangSh()
autocmd filetype sh       call LangSh()
autocmd filetype vim      call LangVim()
