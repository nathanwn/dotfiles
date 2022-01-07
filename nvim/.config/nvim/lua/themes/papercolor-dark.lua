return function()
  vim.opt.background = 'dark'
  vim.cmd [[ colorscheme PaperColor ]]
  require('plugins/lualine')('papercolor_dark')
end
