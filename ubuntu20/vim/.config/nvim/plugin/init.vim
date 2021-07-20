" Stuff that I have not been able to convert to lua

function! SetIndentSize(indentsize)
  let &l:tabstop     = a:indentsize
  let &l:shiftwidth  = a:indentsize
  let &l:softtabstop = a:indentsize
endfunction

function! ToggleConceal()
  if s:conceal_on
    set conceallevel=2
    let s:conceal_on = 0
  else
    set conceallevel=0
    let s:conceal_on = 1
  endif
endfunction

function! RemoveTrailingWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

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

" Show syntax highlighting group under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

function SyntaxLua()
  call SetIndentSize(2)
endfunction

function SyntaxMarkdown()
  call SetIndentSize(2)
endfunction

function SyntaxPascal()
  call SetIndentSize(2)
  let g:pascal_fpc=1
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
autocmd filetype lua             call SyntaxLua()
autocmd filetype markdown        call SyntaxMarkdown()
autocmd filetype pascal          call SyntaxPascal()
autocmd filetype sh              call SyntaxSh()
autocmd filetype typescriptreact call SyntaxTSReact()
autocmd filetype vim             call SyntaxVim()
autocmd filetype yaml            call SyntaxYaml()

" autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * call RemoveTrailingWhitespace()

" Enter Paste Mode
set pastetoggle=<F3>

" Toggle Conceal
let s:conceal_on = 0
nmap \cc :call ToggleConceal()<CR>

" Centering selected text
nmap \ac "xy:echo(AlignCenter(80))<CR>

" Execute selected shell command
vnoremap \ex :w !bash<CR>

" Copy path to clipboard
nmap \cp :let @+=expand("%:p")<CR>
