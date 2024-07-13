function SyntaxC()
  setlocal colorcolumn=80
  " autocmd BufWritePre *.c,*.h execute \\\\\"%! clang-format -style=file" "
  " remove the \\\\\
endfunction

function SyntaxCpp()
  setlocal colorcolumn=80
  " autocmd BufWritePre *.cpp,*.h,*.hpp execute \\\\\"%! clang-format -style=file"
  " remove the \\\\\
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

" autocmd BufEnter,BufNewFile,BufRead *.h set filetype=c
" autocmd BufEnter,BufNewFile,BufRead *.clang-format set filetype=yaml

" autocmd filetype c               call SyntaxC()
" autocmd filetype cpp             call SyntaxCpp()
autocmd filetype html            call SyntaxHtml()
autocmd filetype json            call SyntaxJson()
autocmd filetype markdown        call SyntaxMarkdown()
autocmd filetype pascal          call SyntaxPascal()
autocmd filetype sh              call SyntaxSh()
autocmd filetype typescriptreact call SyntaxTSReact()
autocmd filetype vim             call SyntaxVim()
autocmd filetype yaml            call SyntaxYaml()
