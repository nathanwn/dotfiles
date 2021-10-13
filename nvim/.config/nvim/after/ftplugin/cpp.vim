setlocal colorcolumn=80
" augroup Format
"   autocmd! * <buffer>
"   autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
" augroup END

