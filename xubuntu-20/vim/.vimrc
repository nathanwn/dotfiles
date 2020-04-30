" =============================================================================
" AUTHOR: Minh Nhat Nguyen
" VERSION: 30-04-2020
" =============================================================================


" -----------------------------------------------------------------------------
"                                   PLUGINS
" -----------------------------------------------------------------------------

" TODO: Install plug.vim automatically
" if empty(glob("~/.vim/autoload/plug.vim"))
"   "curl here
" endif
call plug#begin('~/.vim/plugged')
  " = Themes
  Plug 'chriskempson/base16-vim'
  Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
  Plug 'vim-scripts/EditPlus'
  Plug 'morhetz/gruvbox'
  Plug 'nathan-wien/muse.vim'
  Plug 'altercation/vim-colors-solarized'

  " = Better syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " = Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " = Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  " = For neovim only

  if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  else
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}
  endif
call plug#end()

" plasticboy/vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1

" sheerun/vim-polyglot
let g:polyglot_disabled = ['python']


" -----------------------------------------------------------------------------
"                                     EDITOR
" -----------------------------------------------------------------------------
" = Filetype
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
" set colorcolumn=80

" = Remove trailing whitespaces automatically
" autocmd BufWritePre * %s/\s\+$//e

" = Clipboard setting for copy & paste
" Make vim use the system clipboard
set clipboard=unnamed,unnamedplus

" = Error bells: off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" = Cursor
set guicursor=

" = Autocomplete (neovim only)
if has('nvim')
  " = Increase height of message bar
  set cmdheight=2

  " If hidden is not set, TextEdit might fail.
  set hidden

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " Don't give |ins-completion-menu| messages.
  set shortmess+=c

  " Always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " Or use `complete_info` if your vim support it, like:
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif


" -----------------------------------------------------------------------------
"                                  THEME
" -----------------------------------------------------------------------------
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'


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

" = Need this for `a` in normal-mode to work properly
nnoremap e he

" = Remove trailing whitespace
function! RemoveTrailingWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

" autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * call RemoveTrailingWhitespace()

function GetCharUnderCursor()
  return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

function VisualLength()
  exe 'normal "xy'
  return strlen(@x)
endfunction

function AlignCenter(end_col)
  exe 'normal 0'
  if GetCharUnderCursor() == ' '
    exe 'normal w'
  endif
  " select the text
  exe 'normal wv$'
  " calculate selected length
  let select_len = VisualLength()
  " put the cursor at the first comment character
  exe 'normal 0'
  if GetCharUnderCursor() == ' '
    exe 'normal w'
  endif
  " jump to the next <SPACE> after the comment characters
  exe 'normal f '
  " delete spaces before the text
  exe 'normal dw'
  " calculate the number of spaces to insert
  let num_spaces = (a:end_col - col('.') + 1) / 2 - (select_len / 2) - 1
  " pad spaces
  exe 'normal ' . string(num_spaces) . 'i '

  echo "Aligned to center!"
endfunction

" = Keep selection when re-indenting
vnoremap < <gv
vnoremap > >gv

" map <leader>vl "xy:call VisualLength()<CR>
nmap \ac "xy:echo(AlignCenter(80))<CR>
nmap \ace "xy:echo(AlignCenter())<left><left>

" = Execute Shell commands
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
  " autocmd BufWritePre *.c,*.h execute "%! clang-format -style=file"
endfunction

function LangCpp()
  setlocal colorcolumn=80
  " autocmd BufWritePre *.cpp,*.h,*.hpp execute "%! clang-format -style=file"
endfunction

function LangHtml()
  call SetIndentSize(2)
endfunction

function LangJson()
  nmap \ff :%!python3 -m json.tool<CR>:echo('json prettified!')<CR>
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

" autocmd BufEnter,BufNewFile,BufRead *.c   call LangC()
" autocmd BufEnter,BufNewFile,BufRead *.h   call LangC()
" autocmd BufEnter,BufNewFile,BufRead *.cpp call LangCpp()

autocmd BufEnter,BufNewFile,BufRead *.h set filetype=c
autocmd BufEnter,BufNewFile,BufRead *.clang-format set filetype=yaml

autocmd filetype c        call LangC()
autocmd filetype cpp      call LangCpp()
autocmd filetype html     call LangHtml()
autocmd filetype json     call LangJson()
autocmd filetype markdown call LangMarkdown()
autocmd filetype sh       call LangSh()
autocmd filetype vim      call LangVim()
