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
