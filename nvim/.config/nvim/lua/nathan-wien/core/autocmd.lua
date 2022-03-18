vim.cmd([[
  function! PackerAutoCompile()
    exec "PackerCompile"
    exec "luafile $MYVIMRC"
  endfunction

  augroup packer_compile
    autocmd BufWritePost */.config/nvim/*.lua call PackerAutoCompile()
  augroup END
]])
