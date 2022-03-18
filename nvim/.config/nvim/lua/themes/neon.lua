return function()
  vim.cmd([[ colorscheme neon ]])
  require('plugins/lualine')('neon')
end
