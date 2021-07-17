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
"                              Editor Settings
" -----------------------------------------------------------------------------
" = Filetype
filetype plugin indent on
" = Line number
set nu rnu
" = Indentation
set autoindent     " indents like the previous line
"set smartindent   " add one level of indentation in some cases
set tabstop=4      " hard tab stop
set shiftwidth=4   " when indenting with '>', add 4 spaces
set softtabstop=4  " soft tab stop
set expandtab      " on pressing tab, insert 4 spaces
" = Accessing system clipboard
set clipboard=unnamed,unnamedplus
" = Cursor
set guicursor=
" = Theme
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'

" -----------------------------------------------------------------------------
"                                Key bindings
" -----------------------------------------------------------------------------
" = Leader key
" By default it is the backslash key
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
"                              Plugin Settings
" -----------------------------------------------------------------------------
" = tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" = vim-fugitive
" git status
nmap <leader>gs :G<CR>
" git diff select left/right
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>

" = vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled=0  " prevent conflict with coc

" = Coc
" All the extensions that I use
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-eslint',
\ 'coc-pyright',
\ 'coc-clangd'
\ ]

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

  " https://github.com/neoclide/coc.nvim/wiki/Using-workspaceFolders
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
endif

" = fzf
" Thanks to: https://www.chrisatmachine.com/Neovim/08-fzf/
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

map <C-f>f :Files<CR>
map <C-f>b :Buffers<CR>
nnoremap <C-f>g :Rg<CR>
nnoremap <C-f>t :Tags<CR>
nnoremap <C-f>m :Marks<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" -----------------------------------------------------------------------------
"                         Language-specific Settings
" -----------------------------------------------------------------------------
function! SetIndentSize(indentsize)
  let &l:tabstop     = a:indentsize
  let &l:shiftwidth  = a:indentsize
  let &l:softtabstop = a:indentsize
endfunction

function SyntaxC()
  setlocal colorcolumn=80
  " autocmd BufWritePre *.c,*.h execute "%! clang-format -style=file"
endfunction

function SyntaxCpp()
  setlocal colorcolumn=80
  " autocmd BufWritePre *.cpp,*.h,*.hpp execute "%! clang-format -style=file"
endfunction

function SyntaxHtml()
  call SetIndentSize(2)
endfunction

function SyntaxJson()
  nmap \ff :%!python3 -m json.tool<CR>:echo('json prettified!')<CR>
endfunction

function SyntaxPascal()
  call SetIndentSize(2)
endfunction

function SyntaxMarkdown()
  call SetIndentSize(2)
endfunction

function SyntaxTSReact()
  call SetIndentSize(2)
endfunction

function SyntaxSh()
  call SetIndentSize(2)
endfunction

function SyntaxVim()
  call SetIndentSize(2)
endfunction

function SyntaxYaml()
  call SetIndentSize(2)
endfunction

autocmd BufEnter,BufNewFile,BufRead *.h set filetype=c
autocmd BufEnter,BufNewFile,BufRead *.clang-format set filetype=yaml

autocmd filetype c               call SyntaxC()
autocmd filetype cpp             call SyntaxCpp()
autocmd filetype html            call SyntaxHtml()
autocmd filetype json            call SyntaxJson()
autocmd filetype markdown        call SyntaxMarkdown()
autocmd filetype pascal          call SyntaxPascal()
autocmd filetype sh              call SyntaxSh()
autocmd filetype typescriptreact call SyntaxTSReact()
autocmd filetype vim             call SyntaxVim()
autocmd filetype yaml            call SyntaxYaml()
